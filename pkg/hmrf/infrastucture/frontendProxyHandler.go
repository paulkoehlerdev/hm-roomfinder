package infrastucture

import (
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"net/http"
	"net/http/httputil"
	"net/url"
)

var _ repository.FrontendHandler = (*FrontendProxyHandler)(nil)

// FrontendProxyHandler implements repository.FrontendHandler
type FrontendProxyHandler struct {
	ProxyUrl *url.URL
}

func (p FrontendProxyHandler) GetHttpHandler() http.Handler {
	rp := httputil.NewSingleHostReverseProxy(p.ProxyUrl)
	return rp
}
