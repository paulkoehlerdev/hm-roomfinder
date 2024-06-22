package document

import "github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"

type Document struct {
	Data map[string]interface{}   `mapstructure:",remain"`
	Geo  geojson.CoordinatesPoint `mapstructure:"_geo"`
	Id   int64                    `mapstructure:"_doc_id"`
}
