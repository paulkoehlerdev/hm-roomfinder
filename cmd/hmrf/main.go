package main

import (
	"context"
	"database/sql"
	"flag"
	"github.com/lmittmann/tint"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/application"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/service"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/infrastucture"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/interface/http"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/libraries/sqlite"
	"log/slog"
	"net"
	"net/url"
	"os"
	"os/signal"
	"time"
)

func main() {
	start := time.Now()

	logger := slog.New(tint.NewHandler(os.Stderr, &tint.Options{
		AddSource: true,
		Level:     slog.LevelDebug,
	}))

	logger.Info("starting hmrf")

	configFlag := flag.String("config", "config.hcl", "Path to configuration file")
	flag.Parse()

	conf, err := loadConfig(*configFlag)
	if err != nil {
		logger.Error("error loading configuration", "error", err)
		return
	}

	logger = slog.New(tint.NewHandler(os.Stderr, &tint.Options{
		AddSource: true,
		Level:     conf.Logger.Level(),
	}))

	dbconn, err := sqlite.CreateDatabaseConnection(conf.Database.Path)
	if err != nil {
		logger.Error("error connecting to database", "error", err)
		return
	}

	// initialize management app
	managementApp := buildManagementApplication(dbconn, logger)

	// migrate db
	if conf.Database.MigrationTimeoutSeconds == nil {
		conf.Database.MigrationTimeoutSeconds = ptr(30)
	}
	migrationTimeoutContext, cancel := context.WithTimeout(context.Background(), time.Duration(*conf.Database.MigrationTimeoutSeconds)*time.Second)
	defer cancel()

	err = managementApp.ExecuteMigrations(migrationTimeoutContext)
	if err != nil {
		logger.Error("error executing migrations", "error", err)
		return
	}

	// initialize frontend app
	frontendApp := buildFrontendApplication(conf, logger)

	// initialize http server
	server := http.ServerImpl{}
	server.RegisterMiddleware(http.NewLoggerMiddleware(logger))

	server.Register(http.NewFrontendService(frontendApp))

	l, err := net.Listen("tcp", conf.Server.Bind)
	if err != nil {
		logger.Error("error creating listener", "error", err.Error())
		return
	}

	err = server.Start(l)
	if err != nil {
		logger.Error("error starting server", "error", err.Error())
		return
	}

	logger.Info("server started", "bind", conf.Server.Bind)

	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt)
	defer cancel()

	logger.Info("hmrf up and running", "duration", time.Since(start))

	<-ctx.Done()

	shutdownCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	server.Shutdown(shutdownCtx)
}

func buildFrontendApplication(config config, logger *slog.Logger) application.Frontend {
	var repo repository.FrontendHandler
	switch {
	case config.Frontend != nil && config.Frontend.ProxyUrl != nil:
		url, err := url.Parse(*config.Frontend.ProxyUrl)
		if err == nil {
			repo = infrastucture.FrontendProxyHandler{ProxyUrl: url}
			logger.Debug("using proxy for frontend")
			break
		}
		logger.Error("error parsing proxy url", "error", err.Error())
		fallthrough
	default:
		repo = infrastucture.FrontendEmbedHandler{}
		logger.Debug("using embedded filesystem for frontend")
	}

	svc := service.FrontendHandlerImpl{Repo: repo}

	return application.FrontendImpl{FrontendHandlerService: svc}
}

func buildManagementApplication(db *sql.DB, logger *slog.Logger) application.Management {
	migrationsRepo := &infrastucture.SqliteMigrationsExecutor{Database: db}

	migrationsSvc := &service.DatabaseMigrationsExecutorImpl{
		Logger: logger,
		Repo:   migrationsRepo,
	}

	return application.ManagementImpl{DBMigrationsExecutorService: migrationsSvc}
}

func ptr[T any](v T) *T {
	return &v
}
