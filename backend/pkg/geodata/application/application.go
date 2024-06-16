package application

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/service/geodataService"
)

type Application interface {
	GetBuildings(ctx context.Context) (geojson.FeatureCollectionPolygon, error)
	GetLevels(ctx context.Context, buildingID int64) (geojson.FeatureCollectionPolygon, error)
	GetRooms(ctx context.Context, levelID int64) (geojson.FeatureCollectionPolygon, error)
	GetDoors(ctx context.Context, levelID int64) (geojson.FeatureCollectionPoint, error)
}

var _ Application = (*ApplicationImpl)(nil)

type ApplicationImpl struct {
	geodataService geodataService.GeodataService
}

func New(geodataService geodataService.GeodataService) ApplicationImpl {
	return ApplicationImpl{
		geodataService: geodataService,
	}
}

func (a ApplicationImpl) GetBuildings(ctx context.Context) (geojson.FeatureCollectionPolygon, error) {
	return a.geodataService.GetBuildings(ctx)
}

func (a ApplicationImpl) GetLevels(ctx context.Context, buildingID int64) (geojson.FeatureCollectionPolygon, error) {
	return a.geodataService.GetLevels(ctx, buildingID)
}

func (a ApplicationImpl) GetRooms(ctx context.Context, levelID int64) (geojson.FeatureCollectionPolygon, error) {
	return a.geodataService.GetRooms(ctx, levelID)
}

func (a ApplicationImpl) GetDoors(ctx context.Context, levelID int64) (geojson.FeatureCollectionPoint, error) {
	return a.geodataService.GetDoors(ctx, levelID)
}
