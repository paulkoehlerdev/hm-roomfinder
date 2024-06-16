package handlers

import (
	"context"
	"errors"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/application"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/domain/entities/geojson"
	"github.com/paulkoehlerdev/hm-roomfinder/backend/pkg/geodata/interface/http/api/geodata"
	"log/slog"
)

var _ geodata.StrictServerInterface = (*GeodataServerImpl)(nil)

type GeodataServerImpl struct {
	application application.Application
	logger      *slog.Logger
}

func NewGeodataServer(application application.Application, logger *slog.Logger) GeodataServerImpl {
	return GeodataServerImpl{
		application: application,
		logger:      logger,
	}
}

func (s GeodataServerImpl) GetBuilding(ctx context.Context, _ geodata.GetBuildingRequestObject) (geodata.GetBuildingResponseObject, error) {
	fc, err := s.application.GetBuildings(ctx)
	if err != nil {
		return nil, err
	}

	res, err := geojsonFeatureCollectionToGeodataFeatureCollection(fc)
	if err != nil {
		return nil, err
	}

	return geodata.GetBuilding200ApplicationGeoPlusJSONResponse{
		FeatureCollection200ApplicationGeoPlusJSONResponse: geodata.FeatureCollection200ApplicationGeoPlusJSONResponse(res),
	}, nil
}

func (s GeodataServerImpl) GetDoor(ctx context.Context, request geodata.GetDoorRequestObject) (geodata.GetDoorResponseObject, error) {
	fc, err := s.application.GetDoors(ctx, int64(request.Params.LevelId))
	if err != nil {
		return nil, err
	}

	res, err := geojsonFeatureCollectionToGeodataFeatureCollection(fc)
	if err != nil {
		return nil, err
	}

	return geodata.GetDoor200ApplicationGeoPlusJSONResponse{
		FeatureCollection200ApplicationGeoPlusJSONResponse: geodata.FeatureCollection200ApplicationGeoPlusJSONResponse(res),
	}, nil
}

func (s GeodataServerImpl) GetLevel(ctx context.Context, request geodata.GetLevelRequestObject) (geodata.GetLevelResponseObject, error) {
	fc, err := s.application.GetLevels(ctx, int64(request.Params.BuildingId))
	if err != nil {
		return nil, err
	}

	res, err := geojsonFeatureCollectionToGeodataFeatureCollection(fc)
	if err != nil {
		return nil, err
	}

	return geodata.GetLevel200ApplicationGeoPlusJSONResponse{
		FeatureCollection200ApplicationGeoPlusJSONResponse: geodata.FeatureCollection200ApplicationGeoPlusJSONResponse(res),
	}, nil
}

func (s GeodataServerImpl) GetRoom(ctx context.Context, request geodata.GetRoomRequestObject) (geodata.GetRoomResponseObject, error) {
	fc, err := s.application.GetRooms(ctx, int64(request.Params.LevelId))
	if err != nil {
		return nil, err
	}

	res, err := geojsonFeatureCollectionToGeodataFeatureCollection(fc)
	if err != nil {
		return nil, err
	}

	return geodata.GetRoom200ApplicationGeoPlusJSONResponse{
		FeatureCollection200ApplicationGeoPlusJSONResponse: geodata.FeatureCollection200ApplicationGeoPlusJSONResponse(res),
	}, nil
}

func geojsonFeatureCollectionToGeodataFeatureCollection[T geojson.Coordinates](featureCollection geojson.FeatureCollection[T]) (geodata.FeatureCollection, error) {
	convFeatures := make([]geodata.Feature, 0, len(featureCollection.Features))

	for _, feature := range featureCollection.Features {
		feature, err := geojsonFeatureToGeodataFeature[T](feature)
		if err != nil {
			return geodata.FeatureCollection{}, err
		}
		convFeatures = append(convFeatures, feature)
	}

	return geodata.FeatureCollection{
		Type:     geodata.FeatureCollectionTypeFeatureCollection,
		Features: convFeatures,
	}, nil
}

func geojsonFeatureToGeodataFeature[T geojson.Coordinates](feature geojson.Feature[T]) (geodata.Feature, error) {
	geom, err := geojsonGeometryToGeodataGeometry(feature.Geometry)
	if err != nil {
		return geodata.Feature{}, err
	}

	props, err := geojsonPropertiesToGeodataProperties(feature.Properties)
	if err != nil {
		return geodata.Feature{}, err
	}

	return geodata.Feature{
		Type:       geodata.FeatureTypeFeature,
		Geometry:   geom,
		Properties: props,
	}, nil
}

func geojsonPropertiesToGeodataProperties(props map[string]any) (geodata.Feature_Properties, error) {
	if _, ok := props["id"]; !ok {
		return geodata.Feature_Properties{}, errors.New("geodata property 'id' is required")
	}

	intID, ok := props["id"].(int64)
	if !ok {
		return geodata.Feature_Properties{}, errors.New("geodata property 'id' has to be of type int64")
	}

	var name *string
	if n, ok := props["name"]; ok {
		if s, ok := n.(string); ok {
			name = &s
		} else {
			return geodata.Feature_Properties{}, errors.New("geodata property 'name' has to be of type string")
		}
	}

	return geodata.Feature_Properties{
		Id:   int(intID),
		Name: name,
	}, nil
}

func geojsonGeometryToGeodataGeometry[T geojson.Coordinates](geometry geojson.Geometry[T]) (geodata.Feature_Geometry, error) {
	switch v := any(geometry.Coordinates).(type) {
	case geojson.CoordinatesPoint:
		out := &geodata.Feature_Geometry{}
		err := out.FromGeometryPoint(geodata.GeometryPoint{
			Coordinates: v,
			Type:        geodata.Point,
		})
		if err != nil {
			return geodata.Feature_Geometry{}, err
		}
		return *out, nil

	case geojson.CoordinatesPolygon:
		out := &geodata.Feature_Geometry{}
		err := out.FromGeometryPolygon(geodata.GeometryPolygon{
			Coordinates: v,
			Type:        geodata.Polygon,
		})
		if err != nil {
			return geodata.Feature_Geometry{}, err
		}
		return *out, nil

	default:
		return geodata.Feature_Geometry{}, errors.New("unsupported geometry type")
	}
}
