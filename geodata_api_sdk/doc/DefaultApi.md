# geodata_api_sdk.api.DefaultApi

## Load the API package
```dart
import 'package:geodata_api_sdk/api.dart';
```

All URIs are relative to *https://api.hmroomfinder.gosmroutify.xyz/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**buildingGet**](DefaultApi.md#buildingget) | **GET** /building | Get Buildings
[**doorGet**](DefaultApi.md#doorget) | **GET** /door | Get Doors
[**levelGet**](DefaultApi.md#levelget) | **GET** /level | Get Levels
[**reindexGet**](DefaultApi.md#reindexget) | **GET** /reindex | Reindex the Search
[**roomGet**](DefaultApi.md#roomget) | **GET** /room | Get Rooms
[**searchGet**](DefaultApi.md#searchget) | **GET** /search | Search


# **buildingGet**
> FeatureCollection buildingGet()

Get Buildings

Returns outlines and information for all buildings

### Example
```dart
import 'package:geodata_api_sdk/api.dart';

final api = GeodataApiSdk().getDefaultApi();

try {
    final response = api.buildingGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->buildingGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**FeatureCollection**](FeatureCollection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/geo+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **doorGet**
> FeatureCollection doorGet(levelId)

Get Doors

Returns outlines and information for all doors

### Example
```dart
import 'package:geodata_api_sdk/api.dart';

final api = GeodataApiSdk().getDefaultApi();
final int levelId = 56; // int | 

try {
    final response = api.doorGet(levelId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->doorGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **levelId** | **int**|  | 

### Return type

[**FeatureCollection**](FeatureCollection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/geo+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **levelGet**
> FeatureCollection levelGet(buildingId)

Get Levels

Returns outlines and information for all levels

### Example
```dart
import 'package:geodata_api_sdk/api.dart';

final api = GeodataApiSdk().getDefaultApi();
final int buildingId = 56; // int | 

try {
    final response = api.levelGet(buildingId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->levelGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **buildingId** | **int**|  | 

### Return type

[**FeatureCollection**](FeatureCollection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/geo+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reindexGet**
> reindexGet()

Reindex the Search

Reindexes the search functionality

### Example
```dart
import 'package:geodata_api_sdk/api.dart';

final api = GeodataApiSdk().getDefaultApi();

try {
    api.reindexGet();
} catch on DioException (e) {
    print('Exception when calling DefaultApi->reindexGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **roomGet**
> FeatureCollection roomGet(levelId)

Get Rooms

Returns outlines and information for all rooms

### Example
```dart
import 'package:geodata_api_sdk/api.dart';

final api = GeodataApiSdk().getDefaultApi();
final int levelId = 56; // int | 

try {
    final response = api.roomGet(levelId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->roomGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **levelId** | **int**|  | 

### Return type

[**FeatureCollection**](FeatureCollection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/geo+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchGet**
> FeatureCollection searchGet(q, lat, lon)

Search

Make a search

### Example
```dart
import 'package:geodata_api_sdk/api.dart';

final api = GeodataApiSdk().getDefaultApi();
final String q = q_example; // String | 
final double lat = 1.2; // double | 
final double lon = 1.2; // double | 

try {
    final response = api.searchGet(q, lat, lon);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->searchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **lat** | **double**|  | [optional] 
 **lon** | **double**|  | [optional] 

### Return type

[**FeatureCollection**](FeatureCollection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/geo+json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

