package infrastucture

import (
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"net/http"
	"net/http/httputil"
	"net/url"
)

var _ repository.FrontendHandler = (*ProxyHandler)(nil)

// ProxyHandler implements repository.FrontendHandler
type ProxyHandler struct {
	ProxyUrl *url.URL
}

func (p ProxyHandler) GetHttpHandler() http.Handler {
	rp := httputil.NewSingleHostReverseProxy(p.ProxyUrl)
	return rp
}
