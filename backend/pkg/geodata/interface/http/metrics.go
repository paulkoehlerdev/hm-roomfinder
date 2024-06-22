package http

import (
	"context"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"log/slog"
	"net/http"
	"time"
)

func RunMetrics(bindAddr string, logger *slog.Logger) func() {
	server := &http.Server{
		Addr:              bindAddr,
		Handler:           promhttp.Handler(),
		ReadHeaderTimeout: time.Second,
	}

	go func() {
		if err := server.ListenAndServe(); err != nil {
			logger.Error("Failed to start HTTP-Metrics server", "error", err)
		}
	}()

	logger.Info("HTTP Metrics server started", "addr", bindAddr)

	return func() {
		if err := server.Shutdown(context.Background()); err != nil {
			logger.Error("Failed to shutdown HTTP-Metrics server", "error", err)
		}
	}
}
