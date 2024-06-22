//go:generate go run github.com/sqlc-dev/sqlc/cmd/sqlc generate

package geodataRepository

import (
	"context"
	"encoding/json"
	"github.com/jackc/pgx/v5"
	"github.com/mitchellh/mapstructure"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/repositories/geodataRepository"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/libraries/graceful"
	"log/slog"
)

var _ geodataRepository.GeodataRepository = (*GeodataRepositoryImpl)(nil)

type GeodataRepositoryImpl struct {
	q *Queries
}

func NewRepository(dbConnString string, logger *slog.Logger) (*GeodataRepositoryImpl, func(), error) {
	conn, err := pgx.Connect(context.Background(), dbConnString)
	if err != nil {
		return nil, graceful.NoOp, err
	}

	cancelFn := func() {
		err := conn.Close(context.Background())
		if err != nil {
			logger.Error("failed to close connection", "error", err)
		}
	}

	q := New(conn)

	return &GeodataRepositoryImpl{q: q}, cancelFn, nil
}

func (g GeodataRepositoryImpl) GetBuildings(ctx context.Context) (geojson.FeatureCollectionPolygon, error) {
	res, err := g.q.GetBuildings(ctx)
	if err != nil {
		return geojson.FeatureCollectionPolygon{}, err
	}

	return decodeRowsIntoFeatureCollection[GetBuildingsRow, geojson.CoordinatesPolygon](res)
}

func (g GeodataRepositoryImpl) GetLevels(ctx context.Context, buildingID int64) (geojson.FeatureCollectionPolygon, error) {
	res, err := g.q.GetLevels(ctx, buildingID)
	if err != nil {
		return geojson.FeatureCollectionPolygon{}, err
	}

	return decodeRowsIntoFeatureCollection[GetLevelsRow, geojson.CoordinatesPolygon](res)
}

func (g GeodataRepositoryImpl) GetRooms(ctx context.Context, levelID int64) (geojson.FeatureCollectionPolygon, error) {
	res, err := g.q.GetRooms(ctx, levelID)
	if err != nil {
		return geojson.FeatureCollectionPolygon{}, err
	}

	return decodeRowsIntoFeatureCollection[GetRoomsRow, geojson.CoordinatesPolygon](res)
}

func (g GeodataRepositoryImpl) GetDoors(ctx context.Context, levelID int64) (geojson.FeatureCollectionPoint, error) {
	res, err := g.q.GetDoors(ctx, levelID)
	if err != nil {
		return geojson.FeatureCollectionPoint{}, err
	}

	return decodeRowsIntoFeatureCollection[GetDoorsRow, geojson.CoordinatesPoint](res)
}

type RowModelWithGeom interface {
	GetGeom() (geom []byte, bound []byte)
}

func (b GetBuildingsRow) GetGeom() ([]byte, []byte) {
	return b.Geom, b.Bound
}

func (b GetLevelsRow) GetGeom() ([]byte, []byte) {
	return b.Geom, b.Bound
}

func (b GetRoomsRow) GetGeom() ([]byte, []byte) {
	return b.Geom, b.Bound
}

func (b GetDoorsRow) GetGeom() ([]byte, []byte) {
	return b.Geom, b.Bound
}

func decodeRowsIntoFeatureCollection[T RowModelWithGeom, G geojson.Coordinates](res []T) (geojson.FeatureCollection[G], error) {
	var features geojson.FeatureCollection[G]

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
			return geojson.FeatureCollection[G]{}, err
		}

		if attr, ok := props["attr"]; ok {
			if attr, ok := attr.([]byte); ok {
				props["attr"] = json.RawMessage(attr)
			}
		}
		delete(props, "geom")

		geomBytes, boundBytes := feature.GetGeom()

		var geom geojson.Geometry[G]
		if err := json.Unmarshal(geomBytes, &geom); err != nil {
			return geojson.FeatureCollection[G]{}, err
		}

		var bound geojson.GeometryPolygon
		if err := json.Unmarshal(boundBytes, &bound); err != nil {
			return geojson.FeatureCollection[G]{}, err
		}

		features.Features = append(features.Features, geojson.Feature[G]{
			Geometry:   geom,
			Bound:      bound,
			Properties: props,
		})
	}

	return features, nil
}
