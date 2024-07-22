package http

import (
	"context"
	"errors"
	"net"
	"net/http"
)

var (
	AlreadyRunningError = errors.New("http server already running")
	NotRunningError     = errors.New("http server not running")
)

type Middleware func(http.Handler) http.Handler

type Server interface {
	Start(listener net.Listener) error
	Register(service Service)
	RegisterMiddleware(middleware Middleware)
	Shutdown(ctx context.Context) error
}

var _ Server = (*ServerImpl)(nil)

type ServerImpl struct {
	server            *http.Server
	certFile, keyFile *string
	services          []Service
	middlewares       []Middleware
}

func (s *ServerImpl) Start(listener net.Listener) error {
	if s.server != nil {
		return AlreadyRunningError
	}

	handler, err := s.makeHandler()
	if err != nil {
		return err
	}

	server := &http.Server{
		Handler: handler,
	}

	s.server = server

	go func() {
		if s.certFile != nil && s.keyFile != nil {
			s.server.ServeTLS(listener, *s.certFile, *s.keyFile)
		} else {
			s.server.Serve(listener)
		}
	}()

	return nil
}

func (s *ServerImpl) Register(service Service) {
	s.services = append(s.services, service)
}

func (s *ServerImpl) RegisterMiddleware(middleware Middleware) {
	s.middlewares = append(s.middlewares, middleware)
}

func (s *ServerImpl) makeHandler() (http.Handler, error) {
	mux := http.NewServeMux()

	for _, service := range s.services {
		mux.HandleFunc(service.GetPath(), service.ServeHTTP)
	}

	var handler http.Handler = mux

	for _, middleware := range s.middlewares {
		handler = middleware(handler)
	}

	return handler, nil
}

func (s *ServerImpl) Shutdown(ctx context.Context) error {
	if s.server == nil {
		return NotRunningError
	}

	return s.server.Shutdown(ctx)
}
