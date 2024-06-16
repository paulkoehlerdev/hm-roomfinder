package geodataRepository

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
)

type GeodataRepository interface {
	GetBuildings(ctx context.Context) (geojson.FeatureCollectionPolygon, error)
	GetLevels(ctx context.Context, buildingID int64) (geojson.FeatureCollectionPolygon, error)
	GetRooms(ctx context.Context, levelID int64) (geojson.FeatureCollectionPolygon, error)
	GetDoors(ctx context.Context, levelID int64) (geojson.FeatureCollectionPoint, error)
}
