package searchRepository

import (
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/document"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
)

type SearchRepository interface {
	SearchPoint(searchTerm string, point geojson.CoordinatesPoint) (ids []int64, err error)
	Search(searchTerm string) (ids []int64, err error)
	Insert(documents []document.Document) error
}
