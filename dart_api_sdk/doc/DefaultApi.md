# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.hmroomfinder.gosmroutify.xyz/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**buildingGet**](DefaultApi.md#buildingget) | **GET** /building | Get Buildings
[**doorGet**](DefaultApi.md#doorget) | **GET** /door | Get Doors
[**levelGet**](DefaultApi.md#levelget) | **GET** /level | Get Levels
[**roomGet**](DefaultApi.md#roomget) | **GET** /room | Get Rooms


# **buildingGet**
> FeatureCollection buildingGet()

Get Buildings

Returns outlines and information for all buildings

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();

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
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();
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
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();
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

# **roomGet**
> FeatureCollection roomGet(levelId)

Get Rooms

Returns outlines and information for all rooms

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDefaultApi();
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

