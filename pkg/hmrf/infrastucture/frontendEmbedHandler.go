package infrastucture

import (
	"errors"
	"fmt"
	"github.com/paulkoehlerdev/hm-roomfinder/frontend"
	"github.com/paulkoehlerdev/hm-roomfinder/pkg/hmrf/domain/repository"
	"io/fs"
	"log"
	"net/http"
	"os"
)

var _ repository.FrontendHandler = (*FrontendEmbedHandler)(nil)

// FrontendEmbedHandler implements repository.FrontendHandler
type FrontendEmbedHandler struct {
}

func (e FrontendEmbedHandler) GetHttpHandler() http.Handler {
	fsys, err := fs.Sub(frontend.FS, frontend.Subdir)
	if err != nil {
		log.Fatal(err)
	}
	filesystem := http.FS(fsys)
	fileServer := http.FileServer(filesystem)

	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		path := r.URL.Path

		// try to append '.html' if the file doesn't exist
		_, err := filesystem.Open(path)
		if errors.Is(err, os.ErrNotExist) {
			path = fmt.Sprintf("%s.html", path)
		}
		r.URL.Path = path

		fileServer.ServeHTTP(w, r)
	})
}
