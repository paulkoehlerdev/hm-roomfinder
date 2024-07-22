package main

import (
	"context"
	"flag"
	"github.com/lmittmann/tint"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/application"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/service"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/infrastucture"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/interface/http"
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

	frontendApp := buildFrontendApplication(conf, logger)

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
			repo = infrastucture.ProxyHandler{ProxyUrl: url}
			logger.Debug("using proxy for frontend")
			break
		}
		logger.Error("error parsing proxy url", "error", err.Error())
		fallthrough
	default:
		repo = infrastucture.EmbedHandler{}
		logger.Debug("using embedded filesystem for frontend")
	}

	svc := service.FrontendHandlerImpl{Repo: repo}

	return application.FrontendImpl{FrontendHandlerService: svc}
}
