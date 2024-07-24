package service

import (
	"context"
	"fmt"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/entities"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"log/slog"
)

type DatabaseMigrationsExecutor interface {
	ExecuteMigrations(ctx context.Context) error
}

var _ DatabaseMigrationsExecutor = (*DatabaseMigrationsExecutorImpl)(nil)

type DatabaseMigrationsExecutorImpl struct {
	Logger *slog.Logger
	Repo   repository.DatabaseMigrationsExecutor
}

func (d *DatabaseMigrationsExecutorImpl) ExecuteMigrations(ctx context.Context) error {
	if d.Logger == nil {
		d.Logger = slog.Default()
	}

	err := d.Repo.SetupExecutor(ctx)
	if err != nil {
		return fmt.Errorf("setup repository failed: %w", err)
	}

	availableMigrations, err := d.Repo.LoadAvailableMigrations(ctx)
	if err != nil {
		return fmt.Errorf("failed loading available migrations: %w", err)
	}

	executedMigrations, err := d.Repo.LoadExecutedMigrations(ctx)
	if err != nil {
		return fmt.Errorf("failed loading executed migrations: %w", err)
	}

	executedMigrationsSet := make(map[int]entities.DatabaseMigration)
	for _, executedMigration := range executedMigrations {
		executedMigrationsSet[executedMigration.Index] = executedMigration
	}

	var newMigrations []entities.DatabaseMigration
	for _, migration := range availableMigrations {
		if _, ok := executedMigrationsSet[migration.Index]; ok {
			continue
		}

		newMigrations = append(newMigrations, migration)
		d.Logger.Info("executing migration", "index", migration.Index, "name", migration.Name)
	}

	err = d.Repo.ExecuteMigrations(ctx, newMigrations)
	if err != nil {
		return fmt.Errorf("failed executing migrations: %w", err)
	}

	return nil
}
