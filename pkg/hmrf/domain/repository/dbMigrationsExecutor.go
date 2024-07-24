package repository

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/entities"
)

type DatabaseMigrationsExecutor interface {
	SetupExecutor(context.Context) error
	LoadExecutedMigrations(context.Context) ([]entities.DatabaseMigration, error)
	LoadAvailableMigrations(context.Context) ([]entities.DatabaseMigration, error)
	ExecuteMigrations(context.Context, []entities.DatabaseMigration) error
}
