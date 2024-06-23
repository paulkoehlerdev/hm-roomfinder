package geojson

import (
	"encoding/json"
	"github.com/mitchellh/mapstructure"
)

type RowModelWithGeom interface {
	GetGeom() (geom []byte, bound []byte)
}

func DecodeRowsIntoFeatureCollection[T RowModelWithGeom, G Coordinates](res []T) (FeatureCollection[G], error) {
	var features FeatureCollection[G]

	for _, feature := range res {
		props := make(map[string]interface{})

		decoder, err := mapstructure.NewDecoder(&mapstructure.DecoderConfig{
			Result:  &props,
			TagName: "json",
		})
		if err != nil {
			return features, err
		}

		if err := decoder.Decode(feature); err != nil {
			return FeatureCollection[G]{}, err
		}

		if attr, ok := props["attr"]; ok {
			if attr, ok := attr.([]byte); ok {
				props["attr"] = json.RawMessage(attr)
			}
		}
		delete(props, "geom")
		delete(props, "bound")

		geomBytes, boundBytes := feature.GetGeom()

		var geom Geometry[G]
		if err := json.Unmarshal(geomBytes, &geom); err != nil {
			return FeatureCollection[G]{}, err
		}

		var bound GeometryPolygon
		if err := json.Unmarshal(boundBytes, &bound); err != nil {
			return FeatureCollection[G]{}, err
		}

		features.Features = append(features.Features, Feature[G]{
			Geometry:   geom,
			Bound:      bound,
			Properties: props,
		})
	}

	return features, nil
}
