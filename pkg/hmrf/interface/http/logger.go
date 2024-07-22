package http

import (
	"log/slog"
	"net/http"
	"time"
)

type responseWriter struct {
	http.ResponseWriter
	StatusCode *int
}

func (r *responseWriter) WriteHeader(statusCode int) {
	r.StatusCode = &statusCode
	r.ResponseWriter.WriteHeader(statusCode)
}

func NewLoggerMiddleware(logger *slog.Logger) Middleware {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			start := time.Now()

			rw := &responseWriter{ResponseWriter: w}
			next.ServeHTTP(rw, r)

			logger.Debug("http request", "method", r.Method, "path", r.URL.Path, "status", rw.StatusCode, "duration", time.Since(start))
		})
	}
}
