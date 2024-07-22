package application

import (
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/service"
	"net/http"
)

type Frontend interface {
	GetFrontendHttpHandler() http.Handler
}

var _ Frontend = (*FrontendImpl)(nil)

type FrontendImpl struct {
	FrontendHandlerService service.FrontendHandler
}

func (a FrontendImpl) GetFrontendHttpHandler() http.Handler {
	return a.FrontendHandlerService.GetHttpHandler()
}
