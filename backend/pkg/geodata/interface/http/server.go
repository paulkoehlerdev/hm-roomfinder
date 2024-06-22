package http

import (
	"context"
	"github.com/mvrilo/go-redoc"
	strictnethttp "github.com/oapi-codegen/runtime/strictmiddleware/nethttp"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/application"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/interface/http/api/geodata"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/interface/http/handlers"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"log/slog"
	"net/http"
	"time"
)

func Run(application application.Application, bindAddr string, logger *slog.Logger) func() {
	mux := http.NewServeMux()

	doc := redoc.Redoc{
		Title:       "Example API",
		Description: "Example API Description",
		SpecFile:    "./pkg/geodata/interface/http/api/geodata/openapi.yaml",
		SpecPath:    "/openapi.yaml",
		DocsPath:    "/",
	}

	RegisterGeodataServer(
		mux,
		handlers.NewGeodataServer(application, logger),
		logger,
	)

	mux.Handle("/", doc.Handler())

	server := &http.Server{
		Addr:              bindAddr,
		Handler:           mux,
		ReadHeaderTimeout: time.Second,
	}

	go func() {
		err := server.ListenAndServe()
		if err != nil {
			logger.Error("Failed to start HTTP server", "error", err)
		}
	}()

	logger.Info("HTTP server started", "addr", bindAddr)

	return func() {
		if err := server.Shutdown(context.Background()); err != nil {
			logger.Error("Failed to shutdown HTTP server", "error", err)
		}
	}
}

func RegisterGeodataServer(mux *http.ServeMux, s handlers.GeodataServerImpl, logger *slog.Logger) http.Handler {
	ssi := geodata.NewStrictHandler(s, []geodata.StrictMiddlewareFunc{
		LoggingMiddleware(logger),
		MetricsMiddleware(),
	})
	return geodata.HandlerFromMuxWithBaseURL(ssi, mux, "/v1")
}

func MetricsMiddleware() geodata.StrictMiddlewareFunc {
	reqRecieved := promauto.NewCounter(prometheus.CounterOpts{
		Name: "geodata_http_request_recieved",
	})

	reqFailed := promauto.NewCounter(prometheus.CounterOpts{
		Name: "geodata_http_request_failed",
	})

	reqSuccess := promauto.NewCounter(prometheus.CounterOpts{
		Name: "geodata_http_request_success",
	})

	return func(f strictnethttp.StrictHTTPHandlerFunc, operationID string) strictnethttp.StrictHTTPHandlerFunc {
		return func(ctx context.Context, w http.ResponseWriter, r *http.Request, request interface{}) (response interface{}, err error) {
			reqRecieved.Inc()

			response, err = f(ctx, w, r, request)
			if err != nil {
				reqFailed.Inc()
			} else {
				reqSuccess.Inc()
			}
			return response, err
		}
	}
}

func LoggingMiddleware(logger *slog.Logger) geodata.StrictMiddlewareFunc {
	return func(f strictnethttp.StrictHTTPHandlerFunc, operationID string) strictnethttp.StrictHTTPHandlerFunc {
		return func(ctx context.Context, w http.ResponseWriter, r *http.Request, request interface{}) (response interface{}, err error) {
			logger.Debug("Request Received", "path", r.URL.Path)
			response, err = f(ctx, w, r, request)
			if err != nil {
				logger.Debug("Request Failed", "path", r.URL.Path, "error", err)
			}
			return response, err
		}
	}
}
