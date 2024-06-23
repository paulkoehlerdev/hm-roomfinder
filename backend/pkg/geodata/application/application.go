package application

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/service/geodataService"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/service/searchService"
)

type Application interface {
	GetBuildings(ctx context.Context) (geojson.FeatureCollectionPolygon, error)
	GetLevels(ctx context.Context, buildingID int64) (geojson.FeatureCollectionPolygon, error)
	GetRooms(ctx context.Context, levelID int64) (geojson.FeatureCollectionPolygon, error)
	GetDoors(ctx context.Context, levelID int64) (geojson.FeatureCollectionPoint, error)
	ReindexSearch(ctx context.Context) error
	Search(ctx context.Context, query string, point *geojson.CoordinatesPoint) (geojson.FeatureCollectionPolygon, error)
}

var _ Application = (*ApplicationImpl)(nil)

type ApplicationImpl struct {
	geodataService geodataService.GeodataService
	searchService  searchService.SearchService
}

func New(geodataService geodataService.GeodataService, searchService searchService.SearchService) ApplicationImpl {
	return ApplicationImpl{
		geodataService: geodataService,
		searchService:  searchService,
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

func (a ApplicationImpl) ReindexSearch(ctx context.Context) error {
	return a.searchService.Reindex(ctx)
}

func (a ApplicationImpl) Search(ctx context.Context, query string, coos *geojson.CoordinatesPoint) (geojson.FeatureCollectionPolygon, error) {
	return a.searchService.Search(ctx, query, coos)
}
