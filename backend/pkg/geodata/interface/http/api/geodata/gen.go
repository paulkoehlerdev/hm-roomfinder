//go:build go1.22

// Package geodata provides primitives to interact with the openapi HTTP API.
//
// Code generated by github.com/oapi-codegen/oapi-codegen/v2 version v2.3.0 DO NOT EDIT.
package geodata

import (
	"bytes"
	"compress/gzip"
	"context"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"path"
	"strings"

	"github.com/getkin/kin-openapi/openapi3"
	"github.com/oapi-codegen/runtime"
	strictnethttp "github.com/oapi-codegen/runtime/strictmiddleware/nethttp"
)

// Defines values for FeatureType.
const (
	FeatureTypeFeature FeatureType = "Feature"
)

// Defines values for FeatureCollectionType.
const (
	FeatureCollectionTypeFeatureCollection FeatureCollectionType = "FeatureCollection"
)

// Defines values for GeometryPointType.
const (
	Point GeometryPointType = "Point"
)

// Defines values for GeometryPolygonType.
const (
	Polygon GeometryPolygonType = "Polygon"
)

// Feature defines model for Feature.
type Feature struct {
	Geometry   Feature_Geometry   `json:"geometry"`
	Properties Feature_Properties `json:"properties"`
	Type       FeatureType        `json:"type"`
}

// Feature_Geometry defines model for Feature.Geometry.
type Feature_Geometry struct {
	union json.RawMessage
}

// Feature_Properties defines model for Feature.Properties.
type Feature_Properties struct {
	// Id ID of Feature
	Id int `json:"id"`

	// Name Name of Feature
	Name                 *string                `json:"name,omitempty"`
	AdditionalProperties map[string]interface{} `json:"-"`
}

// FeatureType defines model for Feature.Type.
type FeatureType string

// FeatureCollection defines model for FeatureCollection.
type FeatureCollection struct {
	Features []Feature             `json:"features"`
	Type     FeatureCollectionType `json:"type"`
}

// FeatureCollectionType defines model for FeatureCollection.Type.
type FeatureCollectionType string

// GeometryPoint defines model for GeometryPoint.
type GeometryPoint struct {
	Coordinates []float64         `json:"coordinates"`
	Type        GeometryPointType `json:"type"`
}

// GeometryPointType defines model for GeometryPoint.Type.
type GeometryPointType string

// GeometryPolygon defines model for GeometryPolygon.
type GeometryPolygon struct {
	Coordinates [][][]float64       `json:"coordinates"`
	Type        GeometryPolygonType `json:"type"`
}

// GeometryPolygonType defines model for GeometryPolygon.Type.
type GeometryPolygonType string

// FeatureCollection200 defines model for FeatureCollection200.
type FeatureCollection200 = FeatureCollection

// GetDoorParams defines parameters for GetDoor.
type GetDoorParams struct {
	LevelId int `form:"level_id" json:"level_id"`
}

// GetLevelParams defines parameters for GetLevel.
type GetLevelParams struct {
	BuildingId int `form:"building_id" json:"building_id"`
}

// GetRoomParams defines parameters for GetRoom.
type GetRoomParams struct {
	LevelId int `form:"level_id" json:"level_id"`
}

// Getter for additional properties for Feature_Properties. Returns the specified
// element and whether it was found
func (a Feature_Properties) Get(fieldName string) (value interface{}, found bool) {
	if a.AdditionalProperties != nil {
		value, found = a.AdditionalProperties[fieldName]
	}
	return
}

// Setter for additional properties for Feature_Properties
func (a *Feature_Properties) Set(fieldName string, value interface{}) {
	if a.AdditionalProperties == nil {
		a.AdditionalProperties = make(map[string]interface{})
	}
	a.AdditionalProperties[fieldName] = value
}

// Override default JSON handling for Feature_Properties to handle AdditionalProperties
func (a *Feature_Properties) UnmarshalJSON(b []byte) error {
	object := make(map[string]json.RawMessage)
	err := json.Unmarshal(b, &object)
	if err != nil {
		return err
	}

	if raw, found := object["id"]; found {
		err = json.Unmarshal(raw, &a.Id)
		if err != nil {
			return fmt.Errorf("error reading 'id': %w", err)
		}
		delete(object, "id")
	}

	if raw, found := object["name"]; found {
		err = json.Unmarshal(raw, &a.Name)
		if err != nil {
			return fmt.Errorf("error reading 'name': %w", err)
		}
		delete(object, "name")
	}

	if len(object) != 0 {
		a.AdditionalProperties = make(map[string]interface{})
		for fieldName, fieldBuf := range object {
			var fieldVal interface{}
			err := json.Unmarshal(fieldBuf, &fieldVal)
			if err != nil {
				return fmt.Errorf("error unmarshaling field %s: %w", fieldName, err)
			}
			a.AdditionalProperties[fieldName] = fieldVal
		}
	}
	return nil
}

// Override default JSON handling for Feature_Properties to handle AdditionalProperties
func (a Feature_Properties) MarshalJSON() ([]byte, error) {
	var err error
	object := make(map[string]json.RawMessage)

	object["id"], err = json.Marshal(a.Id)
	if err != nil {
		return nil, fmt.Errorf("error marshaling 'id': %w", err)
	}

	if a.Name != nil {
		object["name"], err = json.Marshal(a.Name)
		if err != nil {
			return nil, fmt.Errorf("error marshaling 'name': %w", err)
		}
	}

	for fieldName, field := range a.AdditionalProperties {
		object[fieldName], err = json.Marshal(field)
		if err != nil {
			return nil, fmt.Errorf("error marshaling '%s': %w", fieldName, err)
		}
	}
	return json.Marshal(object)
}

// AsGeometryPolygon returns the union data inside the Feature_Geometry as a GeometryPolygon
func (t Feature_Geometry) AsGeometryPolygon() (GeometryPolygon, error) {
	var body GeometryPolygon
	err := json.Unmarshal(t.union, &body)
	return body, err
}

// FromGeometryPolygon overwrites any union data inside the Feature_Geometry as the provided GeometryPolygon
func (t *Feature_Geometry) FromGeometryPolygon(v GeometryPolygon) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}

// MergeGeometryPolygon performs a merge with any union data inside the Feature_Geometry, using the provided GeometryPolygon
func (t *Feature_Geometry) MergeGeometryPolygon(v GeometryPolygon) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}

	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}

// AsGeometryPoint returns the union data inside the Feature_Geometry as a GeometryPoint
func (t Feature_Geometry) AsGeometryPoint() (GeometryPoint, error) {
	var body GeometryPoint
	err := json.Unmarshal(t.union, &body)
	return body, err
}

// FromGeometryPoint overwrites any union data inside the Feature_Geometry as the provided GeometryPoint
func (t *Feature_Geometry) FromGeometryPoint(v GeometryPoint) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}

// MergeGeometryPoint performs a merge with any union data inside the Feature_Geometry, using the provided GeometryPoint
func (t *Feature_Geometry) MergeGeometryPoint(v GeometryPoint) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}

	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}

func (t Feature_Geometry) MarshalJSON() ([]byte, error) {
	b, err := t.union.MarshalJSON()
	return b, err
}

func (t *Feature_Geometry) UnmarshalJSON(b []byte) error {
	err := t.union.UnmarshalJSON(b)
	return err
}

// ServerInterface represents all server handlers.
type ServerInterface interface {
	// Get Buildings
	// (GET /building)
	GetBuilding(w http.ResponseWriter, r *http.Request)
	// Get Doors
	// (GET /door)
	GetDoor(w http.ResponseWriter, r *http.Request, params GetDoorParams)
	// Get Levels
	// (GET /level)
	GetLevel(w http.ResponseWriter, r *http.Request, params GetLevelParams)
	// Get Rooms
	// (GET /room)
	GetRoom(w http.ResponseWriter, r *http.Request, params GetRoomParams)
}

// ServerInterfaceWrapper converts contexts to parameters.
type ServerInterfaceWrapper struct {
	Handler            ServerInterface
	HandlerMiddlewares []MiddlewareFunc
	ErrorHandlerFunc   func(w http.ResponseWriter, r *http.Request, err error)
}

type MiddlewareFunc func(http.Handler) http.Handler

// GetBuilding operation middleware
func (siw *ServerInterfaceWrapper) GetBuilding(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()

	handler := http.Handler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		siw.Handler.GetBuilding(w, r)
	}))

	for _, middleware := range siw.HandlerMiddlewares {
		handler = middleware(handler)
	}

	handler.ServeHTTP(w, r.WithContext(ctx))
}

// GetDoor operation middleware
func (siw *ServerInterfaceWrapper) GetDoor(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()

	var err error

	// Parameter object where we will unmarshal all parameters from the context
	var params GetDoorParams

	// ------------- Required query parameter "level_id" -------------

	if paramValue := r.URL.Query().Get("level_id"); paramValue != "" {

	} else {
		siw.ErrorHandlerFunc(w, r, &RequiredParamError{ParamName: "level_id"})
		return
	}

	err = runtime.BindQueryParameter("form", true, true, "level_id", r.URL.Query(), &params.LevelId)
	if err != nil {
		siw.ErrorHandlerFunc(w, r, &InvalidParamFormatError{ParamName: "level_id", Err: err})
		return
	}

	handler := http.Handler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		siw.Handler.GetDoor(w, r, params)
	}))

	for _, middleware := range siw.HandlerMiddlewares {
		handler = middleware(handler)
	}

	handler.ServeHTTP(w, r.WithContext(ctx))
}

// GetLevel operation middleware
func (siw *ServerInterfaceWrapper) GetLevel(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()

	var err error

	// Parameter object where we will unmarshal all parameters from the context
	var params GetLevelParams

	// ------------- Required query parameter "building_id" -------------

	if paramValue := r.URL.Query().Get("building_id"); paramValue != "" {

	} else {
		siw.ErrorHandlerFunc(w, r, &RequiredParamError{ParamName: "building_id"})
		return
	}

	err = runtime.BindQueryParameter("form", true, true, "building_id", r.URL.Query(), &params.BuildingId)
	if err != nil {
		siw.ErrorHandlerFunc(w, r, &InvalidParamFormatError{ParamName: "building_id", Err: err})
		return
	}

	handler := http.Handler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		siw.Handler.GetLevel(w, r, params)
	}))

	for _, middleware := range siw.HandlerMiddlewares {
		handler = middleware(handler)
	}

	handler.ServeHTTP(w, r.WithContext(ctx))
}

// GetRoom operation middleware
func (siw *ServerInterfaceWrapper) GetRoom(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()

	var err error

	// Parameter object where we will unmarshal all parameters from the context
	var params GetRoomParams

	// ------------- Required query parameter "level_id" -------------

	if paramValue := r.URL.Query().Get("level_id"); paramValue != "" {

	} else {
		siw.ErrorHandlerFunc(w, r, &RequiredParamError{ParamName: "level_id"})
		return
	}

	err = runtime.BindQueryParameter("form", true, true, "level_id", r.URL.Query(), &params.LevelId)
	if err != nil {
		siw.ErrorHandlerFunc(w, r, &InvalidParamFormatError{ParamName: "level_id", Err: err})
		return
	}

	handler := http.Handler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		siw.Handler.GetRoom(w, r, params)
	}))

	for _, middleware := range siw.HandlerMiddlewares {
		handler = middleware(handler)
	}

	handler.ServeHTTP(w, r.WithContext(ctx))
}

type UnescapedCookieParamError struct {
	ParamName string
	Err       error
}

func (e *UnescapedCookieParamError) Error() string {
	return fmt.Sprintf("error unescaping cookie parameter '%s'", e.ParamName)
}

func (e *UnescapedCookieParamError) Unwrap() error {
	return e.Err
}

type UnmarshalingParamError struct {
	ParamName string
	Err       error
}

func (e *UnmarshalingParamError) Error() string {
	return fmt.Sprintf("Error unmarshaling parameter %s as JSON: %s", e.ParamName, e.Err.Error())
}

func (e *UnmarshalingParamError) Unwrap() error {
	return e.Err
}

type RequiredParamError struct {
	ParamName string
}

func (e *RequiredParamError) Error() string {
	return fmt.Sprintf("Query argument %s is required, but not found", e.ParamName)
}

type RequiredHeaderError struct {
	ParamName string
	Err       error
}

func (e *RequiredHeaderError) Error() string {
	return fmt.Sprintf("Header parameter %s is required, but not found", e.ParamName)
}

func (e *RequiredHeaderError) Unwrap() error {
	return e.Err
}

type InvalidParamFormatError struct {
	ParamName string
	Err       error
}

func (e *InvalidParamFormatError) Error() string {
	return fmt.Sprintf("Invalid format for parameter %s: %s", e.ParamName, e.Err.Error())
}

func (e *InvalidParamFormatError) Unwrap() error {
	return e.Err
}

type TooManyValuesForParamError struct {
	ParamName string
	Count     int
}

func (e *TooManyValuesForParamError) Error() string {
	return fmt.Sprintf("Expected one value for %s, got %d", e.ParamName, e.Count)
}

// Handler creates http.Handler with routing matching OpenAPI spec.
func Handler(si ServerInterface) http.Handler {
	return HandlerWithOptions(si, StdHTTPServerOptions{})
}

type StdHTTPServerOptions struct {
	BaseURL          string
	BaseRouter       *http.ServeMux
	Middlewares      []MiddlewareFunc
	ErrorHandlerFunc func(w http.ResponseWriter, r *http.Request, err error)
}

// HandlerFromMux creates http.Handler with routing matching OpenAPI spec based on the provided mux.
func HandlerFromMux(si ServerInterface, m *http.ServeMux) http.Handler {
	return HandlerWithOptions(si, StdHTTPServerOptions{
		BaseRouter: m,
	})
}

func HandlerFromMuxWithBaseURL(si ServerInterface, m *http.ServeMux, baseURL string) http.Handler {
	return HandlerWithOptions(si, StdHTTPServerOptions{
		BaseURL:    baseURL,
		BaseRouter: m,
	})
}

// HandlerWithOptions creates http.Handler with additional options
func HandlerWithOptions(si ServerInterface, options StdHTTPServerOptions) http.Handler {
	m := options.BaseRouter

	if m == nil {
		m = http.NewServeMux()
	}
	if options.ErrorHandlerFunc == nil {
		options.ErrorHandlerFunc = func(w http.ResponseWriter, r *http.Request, err error) {
			http.Error(w, err.Error(), http.StatusBadRequest)
		}
	}

	wrapper := ServerInterfaceWrapper{
		Handler:            si,
		HandlerMiddlewares: options.Middlewares,
		ErrorHandlerFunc:   options.ErrorHandlerFunc,
	}

	m.HandleFunc("GET "+options.BaseURL+"/building", wrapper.GetBuilding)
	m.HandleFunc("GET "+options.BaseURL+"/door", wrapper.GetDoor)
	m.HandleFunc("GET "+options.BaseURL+"/level", wrapper.GetLevel)
	m.HandleFunc("GET "+options.BaseURL+"/room", wrapper.GetRoom)

	return m
}

type BadRequest400Response struct {
}

type FeatureCollection200ApplicationGeoPlusJSONResponse FeatureCollection

type GetBuildingRequestObject struct {
}

type GetBuildingResponseObject interface {
	VisitGetBuildingResponse(w http.ResponseWriter) error
}

type GetBuilding200ApplicationGeoPlusJSONResponse struct {
	FeatureCollection200ApplicationGeoPlusJSONResponse
}

func (response GetBuilding200ApplicationGeoPlusJSONResponse) VisitGetBuildingResponse(w http.ResponseWriter) error {
	w.Header().Set("Content-Type", "application/geo+json")
	w.WriteHeader(200)

	return json.NewEncoder(w).Encode(response)
}

type GetDoorRequestObject struct {
	Params GetDoorParams
}

type GetDoorResponseObject interface {
	VisitGetDoorResponse(w http.ResponseWriter) error
}

type GetDoor200ApplicationGeoPlusJSONResponse struct {
	FeatureCollection200ApplicationGeoPlusJSONResponse
}

func (response GetDoor200ApplicationGeoPlusJSONResponse) VisitGetDoorResponse(w http.ResponseWriter) error {
	w.Header().Set("Content-Type", "application/geo+json")
	w.WriteHeader(200)

	return json.NewEncoder(w).Encode(response)
}

type GetDoor400Response = BadRequest400Response

func (response GetDoor400Response) VisitGetDoorResponse(w http.ResponseWriter) error {
	w.WriteHeader(400)
	return nil
}

type GetLevelRequestObject struct {
	Params GetLevelParams
}

type GetLevelResponseObject interface {
	VisitGetLevelResponse(w http.ResponseWriter) error
}

type GetLevel200ApplicationGeoPlusJSONResponse struct {
	FeatureCollection200ApplicationGeoPlusJSONResponse
}

func (response GetLevel200ApplicationGeoPlusJSONResponse) VisitGetLevelResponse(w http.ResponseWriter) error {
	w.Header().Set("Content-Type", "application/geo+json")
	w.WriteHeader(200)

	return json.NewEncoder(w).Encode(response)
}

type GetLevel400Response = BadRequest400Response

func (response GetLevel400Response) VisitGetLevelResponse(w http.ResponseWriter) error {
	w.WriteHeader(400)
	return nil
}

type GetRoomRequestObject struct {
	Params GetRoomParams
}

type GetRoomResponseObject interface {
	VisitGetRoomResponse(w http.ResponseWriter) error
}

type GetRoom200ApplicationGeoPlusJSONResponse struct {
	FeatureCollection200ApplicationGeoPlusJSONResponse
}

func (response GetRoom200ApplicationGeoPlusJSONResponse) VisitGetRoomResponse(w http.ResponseWriter) error {
	w.Header().Set("Content-Type", "application/geo+json")
	w.WriteHeader(200)

	return json.NewEncoder(w).Encode(response)
}

type GetRoom400Response = BadRequest400Response

func (response GetRoom400Response) VisitGetRoomResponse(w http.ResponseWriter) error {
	w.WriteHeader(400)
	return nil
}

// StrictServerInterface represents all server handlers.
type StrictServerInterface interface {
	// Get Buildings
	// (GET /building)
	GetBuilding(ctx context.Context, request GetBuildingRequestObject) (GetBuildingResponseObject, error)
	// Get Doors
	// (GET /door)
	GetDoor(ctx context.Context, request GetDoorRequestObject) (GetDoorResponseObject, error)
	// Get Levels
	// (GET /level)
	GetLevel(ctx context.Context, request GetLevelRequestObject) (GetLevelResponseObject, error)
	// Get Rooms
	// (GET /room)
	GetRoom(ctx context.Context, request GetRoomRequestObject) (GetRoomResponseObject, error)
}

type StrictHandlerFunc = strictnethttp.StrictHTTPHandlerFunc
type StrictMiddlewareFunc = strictnethttp.StrictHTTPMiddlewareFunc

type StrictHTTPServerOptions struct {
	RequestErrorHandlerFunc  func(w http.ResponseWriter, r *http.Request, err error)
	ResponseErrorHandlerFunc func(w http.ResponseWriter, r *http.Request, err error)
}

func NewStrictHandler(ssi StrictServerInterface, middlewares []StrictMiddlewareFunc) ServerInterface {
	return &strictHandler{ssi: ssi, middlewares: middlewares, options: StrictHTTPServerOptions{
		RequestErrorHandlerFunc: func(w http.ResponseWriter, r *http.Request, err error) {
			http.Error(w, err.Error(), http.StatusBadRequest)
		},
		ResponseErrorHandlerFunc: func(w http.ResponseWriter, r *http.Request, err error) {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		},
	}}
}

func NewStrictHandlerWithOptions(ssi StrictServerInterface, middlewares []StrictMiddlewareFunc, options StrictHTTPServerOptions) ServerInterface {
	return &strictHandler{ssi: ssi, middlewares: middlewares, options: options}
}

type strictHandler struct {
	ssi         StrictServerInterface
	middlewares []StrictMiddlewareFunc
	options     StrictHTTPServerOptions
}

// GetBuilding operation middleware
func (sh *strictHandler) GetBuilding(w http.ResponseWriter, r *http.Request) {
	var request GetBuildingRequestObject

	handler := func(ctx context.Context, w http.ResponseWriter, r *http.Request, request interface{}) (interface{}, error) {
		return sh.ssi.GetBuilding(ctx, request.(GetBuildingRequestObject))
	}
	for _, middleware := range sh.middlewares {
		handler = middleware(handler, "GetBuilding")
	}

	response, err := handler(r.Context(), w, r, request)

	if err != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, err)
	} else if validResponse, ok := response.(GetBuildingResponseObject); ok {
		if err := validResponse.VisitGetBuildingResponse(w); err != nil {
			sh.options.ResponseErrorHandlerFunc(w, r, err)
		}
	} else if response != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, fmt.Errorf("unexpected response type: %T", response))
	}
}

// GetDoor operation middleware
func (sh *strictHandler) GetDoor(w http.ResponseWriter, r *http.Request, params GetDoorParams) {
	var request GetDoorRequestObject

	request.Params = params

	handler := func(ctx context.Context, w http.ResponseWriter, r *http.Request, request interface{}) (interface{}, error) {
		return sh.ssi.GetDoor(ctx, request.(GetDoorRequestObject))
	}
	for _, middleware := range sh.middlewares {
		handler = middleware(handler, "GetDoor")
	}

	response, err := handler(r.Context(), w, r, request)

	if err != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, err)
	} else if validResponse, ok := response.(GetDoorResponseObject); ok {
		if err := validResponse.VisitGetDoorResponse(w); err != nil {
			sh.options.ResponseErrorHandlerFunc(w, r, err)
		}
	} else if response != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, fmt.Errorf("unexpected response type: %T", response))
	}
}

// GetLevel operation middleware
func (sh *strictHandler) GetLevel(w http.ResponseWriter, r *http.Request, params GetLevelParams) {
	var request GetLevelRequestObject

	request.Params = params

	handler := func(ctx context.Context, w http.ResponseWriter, r *http.Request, request interface{}) (interface{}, error) {
		return sh.ssi.GetLevel(ctx, request.(GetLevelRequestObject))
	}
	for _, middleware := range sh.middlewares {
		handler = middleware(handler, "GetLevel")
	}

	response, err := handler(r.Context(), w, r, request)

	if err != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, err)
	} else if validResponse, ok := response.(GetLevelResponseObject); ok {
		if err := validResponse.VisitGetLevelResponse(w); err != nil {
			sh.options.ResponseErrorHandlerFunc(w, r, err)
		}
	} else if response != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, fmt.Errorf("unexpected response type: %T", response))
	}
}

// GetRoom operation middleware
func (sh *strictHandler) GetRoom(w http.ResponseWriter, r *http.Request, params GetRoomParams) {
	var request GetRoomRequestObject

	request.Params = params

	handler := func(ctx context.Context, w http.ResponseWriter, r *http.Request, request interface{}) (interface{}, error) {
		return sh.ssi.GetRoom(ctx, request.(GetRoomRequestObject))
	}
	for _, middleware := range sh.middlewares {
		handler = middleware(handler, "GetRoom")
	}

	response, err := handler(r.Context(), w, r, request)

	if err != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, err)
	} else if validResponse, ok := response.(GetRoomResponseObject); ok {
		if err := validResponse.VisitGetRoomResponse(w); err != nil {
			sh.options.ResponseErrorHandlerFunc(w, r, err)
		}
	} else if response != nil {
		sh.options.ResponseErrorHandlerFunc(w, r, fmt.Errorf("unexpected response type: %T", response))
	}
}

// Base64 encoded, gzipped, json marshaled Swagger object
var swaggerSpec = []string{

	"H4sIAAAAAAAC/+RXzW7cNhd9FeF+367MiKIk6mfX1IljNGkMpztjUNDSnTFTiVQoysjUmGfppm+SFyso",
	"aWY0P4gncLoouiPFw8N7Di/Jq0codN1ohcq2kD+CwbbRqsW+81KUN/ipw9ZGlLoPJbaFkY2VWkHuhr1x",
	"HNYEXqOwncGfdFVh4SBsmFRoZVFZ1xRNU8lCuEF/ifqHj60jeoS2uMdauNb/DS4gh//5u7D8YbT1jxaA",
	"9XpNDoL60BUFtu2iq7yNFnCokcStMfK4ZmN0g8bKQe8SdY3WrFxbK3y/gPz26yFdjjOudbVauoDIuXip",
	"LKzna3IQgihL6ZSI6nry3ZoOCeBnUTeV698+wl0nq1Kq5W+yhJySXV+JGiGH10BgIYquGhhuA8JIOicw",
	"DLuthBwu8e7LX12J3s/CVK014sufCASw392RcG9sTcCKpYt07aQeBlHhA1b7nTGcV5fwDVON1vVeeyOK",
	"zmgyJZof+ucmHebp1YWnF95m1wnYVePIpLK4ROM07UyZzvtF1HhyZmuNVMs+rQx+6qTBEvJbt/Z8i9F3",
	"H7Hoz8Xw4RFQdbWDbejmT/H1o3sCyS5FT610fECOUnwxQAavLNbtmYduJwSEMWL1FWGT5c+VuI3qlKr9",
	"M3OkqNDalFIJO3THQwL57W0QzGKe8jhkjPEsoFlConQWRGFCoyilnIaMzedk58NCm1pYyKHU3V012XDV",
	"1XdDptTi89UAZwRqqXadp9wZwj/Xkamqr5syXDzfYMt5vpARRjmLI0aDLAsHFEsYjaKQBlmcRhuYYwmC",
	"JOBZxEdYFIRxmiYhoztUxBjLeBqHaRSNsDiIgoAGnAcTHAt4EIeMR5yNsJQmSZhEYRonO1jIkiAOeZzR",
	"NB0lUMYojTKWBfEutpjzNE14EmUjXch4HPIsTFOebJWmWUBTypMsSUYNIQ/TMMp4yKNwC3sqn6YJddz4",
	"B1Lsqf40BYdk+T5J6CZJtdDHF+ebd96N1vVCqhKNd4m6FFZ4L0XxO6rSe9+g+vH6ymsbLORiLAeAQCUL",
	"dK91/jjex/Du6lcg0JkKcri3tmlz39cNqlZ3psCZNkt/nNT6tbQvxs6suW96+dK6jIc3714chwMEHtC0",
	"Q8DBjM6om+LYRSMhh7D/RKAR9r7fOX/zYg2Vgj2WfYO2M6r1dGcrqbD1hCo955DbcqmVt9DGE1XlbZjc",
	"he7ObD96VfYPst28u0D2i7Gxmjp1V29x/skarC9/uroWrrJxS3gvtwG4Mb/U2jxflWM5qejC0TsnjajR",
	"ohkKGOnIP3VoVrB5gHdFwDQdh+JnVyIePt+uCPheThGIzpm8Xxgf+3vRW9F720t6vrk9zUl33/YLnGXv",
	"tOb6lzv8dvCjt9hViM932LGcNNjdHf+t9L3pregv+BbNw0byvrHXRpddv7T3oQcdXdWikbP72myv3tlS",
	"t7XRnZWL1ezz6g//IfD7P6Z94re6EJV3gQ/eK/UgjVa1+3uckue+XznQvW5tntKUDkzz9d8BAAD//2YP",
	"LmzODgAA",
}

// GetSwagger returns the content of the embedded swagger specification file
// or error if failed to decode
func decodeSpec() ([]byte, error) {
	zipped, err := base64.StdEncoding.DecodeString(strings.Join(swaggerSpec, ""))
	if err != nil {
		return nil, fmt.Errorf("error base64 decoding spec: %w", err)
	}
	zr, err := gzip.NewReader(bytes.NewReader(zipped))
	if err != nil {
		return nil, fmt.Errorf("error decompressing spec: %w", err)
	}
	var buf bytes.Buffer
	_, err = buf.ReadFrom(zr)
	if err != nil {
		return nil, fmt.Errorf("error decompressing spec: %w", err)
	}

	return buf.Bytes(), nil
}

var rawSpec = decodeSpecCached()

// a naive cached of a decoded swagger spec
func decodeSpecCached() func() ([]byte, error) {
	data, err := decodeSpec()
	return func() ([]byte, error) {
		return data, err
	}
}

// Constructs a synthetic filesystem for resolving external references when loading openapi specifications.
func PathToRawSpec(pathToFile string) map[string]func() ([]byte, error) {
	res := make(map[string]func() ([]byte, error))
	if len(pathToFile) > 0 {
		res[pathToFile] = rawSpec
	}

	return res
}

// GetSwagger returns the Swagger specification corresponding to the generated code
// in this file. The external references of Swagger specification are resolved.
// The logic of resolving external references is tightly connected to "import-mapping" feature.
// Externally referenced files must be embedded in the corresponding golang packages.
// Urls can be supported but this task was out of the scope.
func GetSwagger() (swagger *openapi3.T, err error) {
	resolvePath := PathToRawSpec("")

	loader := openapi3.NewLoader()
	loader.IsExternalRefsAllowed = true
	loader.ReadFromURIFunc = func(loader *openapi3.Loader, url *url.URL) ([]byte, error) {
		pathToFile := url.String()
		pathToFile = path.Clean(pathToFile)
		getSpec, ok := resolvePath[pathToFile]
		if !ok {
			err1 := fmt.Errorf("path not found: %s", pathToFile)
			return nil, err1
		}
		return getSpec()
	}
	var specData []byte
	specData, err = rawSpec()
	if err != nil {
		return
	}
	swagger, err = loader.LoadFromData(specData)
	if err != nil {
		return
	}
	return
}
