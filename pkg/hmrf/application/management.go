package application

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/service"
)

type Management interface {
	ExecuteMigrations(ctx context.Context) error
}

var _ Management = (*ManagementImpl)(nil)

type ManagementImpl struct {
	DBMigrationsExecutorService service.DatabaseMigrationsExecutor
}

func (a ManagementImpl) ExecuteMigrations(ctx context.Context) error {
	return a.DBMigrationsExecutorService.ExecuteMigrations(ctx)
}
