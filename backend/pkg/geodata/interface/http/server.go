package http

import (
	"context"
	"github.com/mvrilo/go-redoc"
	strictnethttp "github.com/oapi-codegen/runtime/strictmiddleware/nethttp"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/application"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/interface/http/api/geodata"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/interface/http/handlers"
	"log/slog"
	"net/http"
	"time"
)

func Run(application application.Application, bindAddr string, logger *slog.Logger) func() {
	mux := http.NewServeMux()

	doc := redoc.Redoc{
		Title:       "Example API",
		Description: "Example API Description",
		SpecFile:    "./pkg/geodata/interface/http/api/geodata/openapi.json",
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
		ReadHeaderTimeout: time.Second * 1,
	}

	go func() {
		err := server.ListenAndServe()
		if err != nil {
			logger.Error("Failed to start HTTP server", "error", err)
		}
	}()

	logger.Info("HTTP server started", "addr", bindAddr)

	return func() {
		err := server.Close()
		if err != nil {
			logger.Error("Failed to close HTTP server", "error", err)
		}
	}
}

func RegisterGeodataServer(mux *http.ServeMux, s handlers.GeodataServerImpl, logger *slog.Logger) http.Handler {
	ssi := geodata.NewStrictHandler(s, []geodata.StrictMiddlewareFunc{
		LoggingMiddleware(logger),
	})
	return geodata.HandlerFromMuxWithBaseURL(ssi, mux, "/v1")
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
