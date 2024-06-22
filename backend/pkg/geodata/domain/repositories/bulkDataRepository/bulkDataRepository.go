package bulkDataRepository

import (
	"context"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/document"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
)

type BulkDataRepository interface {
	BuildIndex(ctx context.Context) error
	GetAllDocuments(ctx context.Context) ([]document.Document, error)
	GetFeaturesFromSearchResult(ctx context.Context, ids []int64) (geojson.FeatureCollectionPolygon, error)
}
