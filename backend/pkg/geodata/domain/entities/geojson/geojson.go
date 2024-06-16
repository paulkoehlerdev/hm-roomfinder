package geojson

import "encoding/json"

type FeatureCollectionPolygon = FeatureCollection[CoordinatesPolygon]
type FeatureCollectionPoint = FeatureCollection[CoordinatesPoint]

type FeatureCollection[T Coordinates] struct {
	// Type can be left empty. Will be autofilled on MarshalJSON
	Type     string       `json:"type"`
	Features []Feature[T] `json:"features"`
}

func (f *FeatureCollection[T]) MarshalJSON() ([]byte, error) {
	f.Type = "FeatureCollection"
	return json.Marshal(f)
}

type FeaturePolygon = Feature[CoordinatesPolygon]
type FeaturePoint = Feature[CoordinatesPoint]

type Feature[G Coordinates] struct {
	// Type can be left empty. Will be autofilled on MarshalJSON
	Type       string         `json:"type"`
	Geometry   Geometry[G]    `json:"geometry"`
	Properties map[string]any `json:"properties"`
}

func (f *Feature[G]) MarshalJSON() ([]byte, error) {
	f.Type = "Feature"
	return json.Marshal(f)
}

type GeometryPoint = Geometry[CoordinatesPoint]
type GeometryPolygon = Geometry[CoordinatesPolygon]

type Geometry[T Coordinates] struct {
	// Type can be left empty. Will be autofilled on MarshalJSON
	Type        string `json:"type"`
	Coordinates T      `json:"coordinates"`
}

func (g *Geometry[T]) MarshalJSON() ([]byte, error) {
	g.Type = string(g.Coordinates.Type())
	return json.Marshal(g)
}

type Coordinates interface {
	CoordinatesPolygon | CoordinatesPoint
	Type() CoordinateType
}

type CoordinateType string

const (
	CoordinateTypePoint   CoordinateType = "Point"
	CoordinateTypePolygon CoordinateType = "Polygon"
)

type CoordinatesPoint []float64

func (c CoordinatesPoint) Type() CoordinateType {
	return CoordinateTypePoint
}

type CoordinatesPolygon [][][]float64

func (c CoordinatesPolygon) Type() CoordinateType {
	return CoordinateTypePolygon
}
