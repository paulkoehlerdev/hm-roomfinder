package searchRepository

import (
	"encoding/json"
	"fmt"
	"github.com/meilisearch/meilisearch-go"
	"github.com/mitchellh/mapstructure"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/document"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/repositories/searchRepository"
	"log/slog"
)

var _ searchRepository.SearchRepository = (*SearchRepositoryImpl)(nil)

type SearchRepositoryImpl struct {
	logger *slog.Logger
	index  *meilisearch.Index
}

func New(host string, key string, index string, logger *slog.Logger) (*SearchRepositoryImpl, error) {
	client := meilisearch.NewClient(meilisearch.ClientConfig{
		Host:   host,
		APIKey: key,
	})

	meiliIndex := client.Index(index)

	if _, err := meiliIndex.FetchInfo(); err != nil {
		taskInfo, err := client.CreateIndex(&meilisearch.IndexConfig{
			Uid:        index,
			PrimaryKey: "_doc_id",
		})
		if err != nil {
			return nil, err
		}

		task, err := client.WaitForTask(taskInfo.TaskUID)
		if err != nil {
			return nil, err
		}

		if task.Status != meilisearch.TaskStatusSucceeded {
			return nil, fmt.Errorf("task status is %s", task.Status)
		}
	}

	// make _geo sortable
	taskInfo, err := meiliIndex.UpdateSortableAttributes(&[]string{
		"_geo",
	})
	if err != nil {
		return nil, err
	}

	taskRes, err := client.WaitForTask(taskInfo.TaskUID)
	if err != nil {
		return nil, err
	}

	if taskRes.Status != meilisearch.TaskStatusSucceeded {
		return nil, fmt.Errorf("task status is %s", taskRes.Status)
	}

	return &SearchRepositoryImpl{
		logger: logger,
		index:  meiliIndex,
	}, nil
}

func (s SearchRepositoryImpl) SearchPoint(searchTerm string, point geojson.CoordinatesPoint) (id []int64, err error) {
	res, err := s.index.Search(searchTerm, &meilisearch.SearchRequest{
		Limit: 10,
		Sort: []string{
			fmt.Sprintf("_geoPoint(%f, %f):asc", point[0], point[1]),
		},
	})
	if err != nil {
		s.logger.Error(err.Error())
		return nil, err
	}

	return s.getIDsFromSearchResults(res)
}

func (s SearchRepositoryImpl) Search(searchTerm string) (id []int64, err error) {
	res, err := s.index.Search(searchTerm, &meilisearch.SearchRequest{
		Limit: 10,
	})
	if err != nil {
		s.logger.Error(err.Error())
		return nil, err
	}

	return s.getIDsFromSearchResults(res)
}

func (s SearchRepositoryImpl) getIDsFromSearchResults(res *meilisearch.SearchResponse) ([]int64, error) {
	var ids []int64
	for _, hit := range res.Hits {
		hit, ok := hit.(map[string]interface{})
		if !ok {
			return nil, fmt.Errorf("could not cast hit")
		}

		var doc document.Document
		if err := mapstructure.Decode(hit, &doc); err != nil {
			return nil, err
		}

		ids = append(ids, doc.Id)
	}

	return ids, nil
}

func (s SearchRepositoryImpl) Insert(documents []document.Document) error {
	s.logger.Info("Reindexing documents into Meilisearch", "amount", len(documents))

	var documentsArr []map[string]interface{}
	for _, document := range documents {
		doc := make(map[string]interface{})
		if err := mapstructure.Decode(document, &doc); err != nil {
			return err
		}

		documentsArr = append(documentsArr, doc)
	}

	info, err := s.index.AddDocuments(documentsArr)
	if err != nil {
		return err
	}

	if bytes, err := json.Marshal(info); err == nil {
		s.logger.Info("Enqueued new Documents", "info", string(bytes))
	} else {
		s.logger.Error(err.Error())
	}

	return nil
}