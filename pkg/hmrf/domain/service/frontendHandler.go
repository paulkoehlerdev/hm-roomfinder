package service

import (
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"net/http"
)

type FrontendHandler interface {
	GetHttpHandler() http.Handler
}

var _ FrontendHandler = (*FrontendHandlerImpl)(nil)

type FrontendHandlerImpl struct {
	Repo repository.FrontendHandler
}

func (h FrontendHandlerImpl) GetHttpHandler() http.Handler {
	return h.CrossOriginMiddleware(h.Repo.GetHttpHandler())
}

func (h FrontendHandlerImpl) CrossOriginMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Cross-Origin-Embedder-Policy", "credentialless")
		w.Header().Set("Cross-Origin-Opener-Policy", "same-origin")
		next.ServeHTTP(w, r)
	})
}
