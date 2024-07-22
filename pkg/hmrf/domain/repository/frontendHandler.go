package repository

import "net/http"

type FrontendHandler interface {
	GetHttpHandler() http.Handler
}
