package infrastucture

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"github.com/paulkoehlerdev/hm-roomfinder/migrations"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/entities"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"io/fs"
	"strconv"
	"strings"
	"time"
)

var _ repository.DatabaseMigrationsExecutor = (*SqliteMigrationsExecutor)(nil)

type SqliteMigrationsExecutor struct {
	Database *sql.DB
}

func (s *SqliteMigrationsExecutor) SetupExecutor(ctx context.Context) error {
	const MigrationsTable = `
		CREATE TABLE IF NOT EXISTS migrations (
			id INTEGER PRIMARY KEY UNIQUE NOT NULL,
			name TEXT NOT NULL,
			created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		);
	`

	_, err := s.Database.ExecContext(ctx, MigrationsTable)
	if err != nil {
		return fmt.Errorf("could not create migrations table: %w", err)
	}
	return nil
}

func (s *SqliteMigrationsExecutor) LoadExecutedMigrations(ctx context.Context) ([]entities.DatabaseMigration, error) {
	const Query = "SELECT id, name, created_at FROM migrations ORDER BY id ASC"

	rows, err := s.Database.QueryContext(ctx, Query)
	if err != nil {
		return nil, fmt.Errorf("could not load migrations: %w", err)
	}
	defer rows.Close()

	var migrations []entities.DatabaseMigration
	for rows.Next() {
		var migration entities.DatabaseMigration
		var createdAtStr string

		rows.Scan(&migration.Index, &migration.Name, &createdAtStr)

		createdAt, err := time.Parse(time.DateTime, createdAtStr)
		if err != nil {
			return nil, fmt.Errorf("could not parse createdAt: %w", err)
		}

		migration.CreatedAt = &createdAt

		migrations = append(migrations, migration)
	}

	return migrations, nil
}

func (s *SqliteMigrationsExecutor) LoadAvailableMigrations(ctx context.Context) ([]entities.DatabaseMigration, error) {
	entries, err := migrations.FS.ReadDir(".")
	if err != nil {
		return nil, fmt.Errorf("could not read migrations: %w", err)
	}

	var migrations []entities.DatabaseMigration
	var errs []error
	for _, entry := range entries {
		// those are rechecked later but should not bubble up an error
		if entry.IsDir() || !strings.HasSuffix(entry.Name(), ".sql") {
			continue
		}

		migration, err := s.migrationFromDirEntry(entry)
		if err != nil {
			errs = append(errs, err)
			continue
		}

		migrations = append(migrations, migration)
	}

	if len(errs) > 0 {
		return nil, fmt.Errorf("could not load migrations: %w", errors.Join(errs...))
	}
	return migrations, nil
}

func (s *SqliteMigrationsExecutor) migrationFromDirEntry(entry fs.DirEntry) (entities.DatabaseMigration, error) {
	name := entry.Name()
	if !strings.HasSuffix(name, ".sql") || entry.IsDir() {
		return entities.DatabaseMigration{}, fmt.Errorf("migration file %s is not a SQLite file", entry.Name())
	}
	name = strings.TrimSuffix(name, ".sql")

	nameSplit := strings.Split(name, "-")
	if len(nameSplit) != 2 {
		return entities.DatabaseMigration{}, fmt.Errorf(
			"migration file %s is not a valid Migratio file (should be in format '0001-schema.sql')",
			entry.Name(),
		)
	}

	id, err := strconv.Atoi(nameSplit[0])
	if err != nil {
		return entities.DatabaseMigration{}, fmt.Errorf("could not parse migration id: %w", err)
	}

	return entities.DatabaseMigration{
		Index:     id,
		Name:      nameSplit[1],
		CreatedAt: nil,
	}, nil
}

func (s *SqliteMigrationsExecutor) ExecuteMigrations(ctx context.Context, migrations []entities.DatabaseMigration) (err error) {
	const MigrationInsertQuery = `INSERT INTO migrations (id, name) VALUES (?, ?)`

	tx, err := s.Database.BeginTx(ctx, &sql.TxOptions{Isolation: sql.LevelSerializable})
	if err != nil {
		return fmt.Errorf("could not start transaction: %w", err)
	}
	defer tx.Rollback()

	for _, migration := range migrations {
		query, err := s.loadMigrationFromFS(migration)
		if err != nil {
			return fmt.Errorf("could not load migration %s: %w", migration.Name, err)
		}

		_, err = tx.ExecContext(ctx, query)
		if err != nil {
			return fmt.Errorf("could not execute migration %s: %w", migration.Name, err)
		}

		_, err = tx.ExecContext(ctx, MigrationInsertQuery, migration.Index, migration.Name)
		if err != nil {
			return fmt.Errorf("could not insert migration information %s: %w", migration.Name, err)
		}
	}

	err = tx.Commit()
	if err != nil {
		return fmt.Errorf("could not commit transaction: %w", err)
	}

	return nil
}

func (s *SqliteMigrationsExecutor) loadMigrationFromFS(migration entities.DatabaseMigration) (string, error) {
	filename := fmt.Sprintf("%04d-%s.sql", migration.Index, migration.Name)

	bytes, err := migrations.FS.ReadFile(filename)
	if err != nil {
		return "", fmt.Errorf("could not read file %s: %w", filename, err)
	}

	return string(bytes), nil
}
