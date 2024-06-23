package geodataService

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/repositories/geodataRepository"
)

type GeodataService interface {
	GetBuildings(ctx context.Context) (geojson.FeatureCollectionPolygon, error)
	GetLevels(ctx context.Context, buildingID int64) (geojson.FeatureCollectionPolygon, error)
	GetRooms(ctx context.Context, levelID int64) (geojson.FeatureCollectionPolygon, error)
	GetDoors(ctx context.Context, levelID int64) (geojson.FeatureCollectionPoint, error)
}

var _ GeodataService = (*GeodataServiceImpl)(nil)

type GeodataServiceImpl struct {
	repository geodataRepository.GeodataRepository
}

func New(repository geodataRepository.GeodataRepository) *GeodataServiceImpl {
	return &GeodataServiceImpl{
		repository: repository,
	}
}

func (g GeodataServiceImpl) GetBuildings(ctx context.Context) (geojson.FeatureCollectionPolygon, error) {
	return g.repository.GetBuildings(ctx)
}

func (g GeodataServiceImpl) GetLevels(ctx context.Context, buildingID int64) (geojson.FeatureCollectionPolygon, error) {
	return g.repository.GetLevels(ctx, buildingID)
}

func (g GeodataServiceImpl) GetRooms(ctx context.Context, levelID int64) (geojson.FeatureCollectionPolygon, error) {
	return g.repository.GetRooms(ctx, levelID)
}

func (g GeodataServiceImpl) GetDoors(ctx context.Context, levelID int64) (geojson.FeatureCollectionPoint, error) {
	return g.repository.GetDoors(ctx, levelID)
}
