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
	return h.Repo.GetHttpHandler()
}
