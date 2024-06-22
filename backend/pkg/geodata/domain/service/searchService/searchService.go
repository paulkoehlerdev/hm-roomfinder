package searchService

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/repositories/bulkDataRepository"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/repositories/searchRepository"
)

type SearchService interface {
	Reindex(ctx context.Context) error
	Search(ctx context.Context, query string, coos *geojson.CoordinatesPoint) (geojson.FeatureCollectionPolygon, error)
}

var _ SearchService = (*SearchServiceImpl)(nil)

type SearchServiceImpl struct {
	searchRepository   searchRepository.SearchRepository
	bulkDataRepository bulkDataRepository.BulkDataRepository
}

func New(searchRepository searchRepository.SearchRepository, bulkDataRepository bulkDataRepository.BulkDataRepository) *SearchServiceImpl {
	return &SearchServiceImpl{
		searchRepository:   searchRepository,
		bulkDataRepository: bulkDataRepository,
	}
}

func (s SearchServiceImpl) Reindex(ctx context.Context) error {
	err := s.bulkDataRepository.BuildIndex(ctx)
	if err != nil {
		return err
	}

	docs, err := s.bulkDataRepository.GetAllDocuments(ctx)
	if err != nil {
		return err
	}

	err = s.searchRepository.Insert(docs)
	if err != nil {
		return err
	}

	return nil
}

func (s SearchServiceImpl) Search(ctx context.Context, query string, coos *geojson.CoordinatesPoint) (geojson.FeatureCollectionPolygon, error) {
	var ids []int64
	var err error

	if coos != nil {
		ids, err = s.searchRepository.SearchPoint(query, *coos)
	} else {
		ids, err = s.searchRepository.Search(query)
	}

	if err != nil {
		return geojson.FeatureCollectionPolygon{}, err
	}

	return s.bulkDataRepository.GetFeaturesFromSearchResult(ctx, ids)
}
