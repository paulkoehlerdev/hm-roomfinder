package main

import (
	"context"
	"flag"
	"fmt"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/application"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/service/geodataService"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/service/searchService"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/infrastructure/meilisearch/searchRepository"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/infrastructure/pgsql/bulkDataRepository"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/infrastructure/pgsql/geodataRepository"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/interface/http"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/libraries/graceful"
	"io"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	ctx := context.Background()
	ctx, cancel := signal.NotifyContext(ctx, os.Interrupt, os.Kill, syscall.SIGTERM)
	defer cancel()

	if err := run(ctx, os.Args, os.Stdout); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		cancel()
		os.Exit(1) //nolint:gocritic
	}
}

func run(ctx context.Context, args []string, stdout io.Writer) error {
	flagSet := flag.NewFlagSet(args[0], flag.ContinueOnError)

	gful := graceful.New()
	defer gful.Shutdown()

	conf := flagSet.String("config", "config.hcl", "configuration file")

	if err := flagSet.Parse(args[1:]); err != nil {
		return fmt.Errorf("parse flags: %w", err)
	}

	if conf == nil {
		return fmt.Errorf("missing configuration file")
	}

	config, err := loadConfig(*conf)
	if err != nil {
		return fmt.Errorf("loading configuration: %w", err)
	}

	logger := graceful.AddFunc(gful, createLogger(stdout, config.Logger))

	logger.Info("configuration loaded", "config", config)

	geodataRepo, geodataRepoShutdown, err := geodataRepository.NewRepository(config.Database.ConnString(), logger)
	if err != nil {
		return fmt.Errorf("creating geodata repository: %w", err)
	}
	gful.Add(geodataRepoShutdown)

	bulkDataRepo, bulkDataRepoShutdown, err := bulkDataRepository.NewRepository(config.Database.ConnString(), logger)
	if err != nil {
		return fmt.Errorf("creating geodata repository: %w", err)
	}
	gful.Add(bulkDataRepoShutdown)

	searchRepository, err := searchRepository.New(config.SearchDatabase.Host, config.SearchDatabase.Key, config.SearchDatabase.Index, logger)
	if err != nil {
		return fmt.Errorf("creating search repository: %w", err)
	}

	geodataService := geodataService.New(geodataRepo)

	searchService := searchService.New(searchRepository, bulkDataRepo)

	application := application.New(geodataService, searchService)

	serverShutdown := http.Run(application, config.Server.Bind, logger)

	gful.Add(serverShutdown)

	<-ctx.Done()

	fmt.Println("shutting down...")
	return nil
}
