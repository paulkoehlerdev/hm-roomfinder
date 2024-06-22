//go:generate go run github.com/sqlc-dev/sqlc/cmd/sqlc generate

package bulkDataRepository

import (
	"context"
	"encoding/json"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/document"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/repositories/bulkDataRepository"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/libraries/graceful"
	"log/slog"
)

var _ bulkDataRepository.BulkDataRepository = (*BulkDataRepositoryImpl)(nil)

type BulkDataRepositoryImpl struct {
	q      *Queries
	conn   *pgxpool.Pool
	logger *slog.Logger
}

func NewRepository(dbConnString string, logger *slog.Logger) (*BulkDataRepositoryImpl, func(), error) {
	conn, err := pgxpool.New(context.Background(), dbConnString)
	if err != nil {
		return nil, graceful.NoOp, err
	}

	cancelFn := func() {
		conn.Close()
	}

	q := New(conn)

	return &BulkDataRepositoryImpl{
		q:      q,
		conn:   conn,
		logger: logger,
	}, cancelFn, nil
}

func (b BulkDataRepositoryImpl) BuildIndex(ctx context.Context) error {
	tx, err := b.conn.Begin(ctx)
	if err != nil {
		return err
	}

	q := b.q.WithTx(tx)
	err = queryChain(ctx,
		q.ClearDocumentIndex,
		q.CreateDocumentIndexBuilding,
		q.CreateDocumentIndexLevel,
		q.CreateDocumentIndexRoom,
	)
	if err != nil {
		return err
	}

	err = tx.Commit(ctx)
	if err != nil {
		return err
	}

	return nil
}

func (b BulkDataRepositoryImpl) GetAllDocuments(ctx context.Context) ([]document.Document, error) {
	res, err := b.q.GetDocumentInformation(ctx)
	if err != nil {
		return nil, err
	}

	out := make([]document.Document, 0, len(res))
	for _, row := range res {
		if row.DocID == nil {
			continue
		}

		var point geojson.GeometryPoint
		if err := json.Unmarshal(row.Centroid, &point); err != nil {
			return nil, err
		}

		out = append(out, document.Document{
			Data: map[string]interface{}{
				"Name": row.Name,
				"Type": row.Type,
				"Attr": json.RawMessage(row.Attr),
			},
			Geo: document.GeoFromGeojsonPoint(point),
			ID:  *row.DocID,
		})
	}

	return out, nil
}

func (g GetGeojsonInformationForRow) GetGeom() ([]byte, []byte) {
	return g.Geom, g.Bound
}

func (b BulkDataRepositoryImpl) GetFeaturesFromSearchResult(ctx context.Context, ids []int64) (geojson.FeatureCollectionPolygon, error) {
	res, err := b.q.GetGeojsonInformationFor(ctx, ids)
	if err != nil {
		return geojson.FeatureCollectionPolygon{}, err
	}

	return geojson.DecodeRowsIntoFeatureCollection[GetGeojsonInformationForRow, geojson.CoordinatesPolygon](res)
}

func queryChain(ctx context.Context, funcs ...func(ctx context.Context) error) error {
	for _, fn := range funcs {
		if err := fn(ctx); err != nil {
			return err
		}
	}
	return nil
}
