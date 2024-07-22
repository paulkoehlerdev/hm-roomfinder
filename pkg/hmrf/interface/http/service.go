package http

import "net/http"

type Service interface {
	http.Handler
	GetPath() string
}

var _ Service = (*ServiceFunc)(nil)

type ServiceFunc struct {
	path    string
	handler http.Handler
}

func (f ServiceFunc) GetPath() string {
	return f.path
}

func (f ServiceFunc) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
	f.handler.ServeHTTP(writer, request)
}
