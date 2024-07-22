package http

import (
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/application"
)

func NewFrontendService(application application.Frontend) Service {
	return ServiceFunc{"/", application.GetFrontendHttpHandler()}
}
