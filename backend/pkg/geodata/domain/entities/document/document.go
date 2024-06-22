package document

import "github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"

type Document struct {
	Data map[string]interface{} `mapstructure:",remain"`
	Geo  Geo                    `mapstructure:"_geo"`
	Id   int64                  `mapstructure:"_doc_id"`
}

type Geo struct {
	Lat float64 `mapstructure:"lat"`
	Lng float64 `mapstructure:"lng"`
}

func GeoFromGeojsonPoint(point geojson.GeometryPoint) Geo {
	return Geo{
		Lat: point.Coordinates[0],
		Lng: point.Coordinates[1],
	}
}
