# geodata_api_sdk (EXPERIMENTAL)
HM Roomfinder Geodata Backend OpenAPI specification

This Dart package is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 1.0.0
- Build package: org.openapitools.codegen.languages.DartDioClientCodegen

## Requirements

* Dart 2.15.0+ or Flutter 2.8.0+
* Dio 5.0.0+ (https://pub.dev/packages/dio)

## Installation & Usage

### pub.dev
To use the package from [pub.dev](https://pub.dev), please include the following in pubspec.yaml
```yaml
dependencies:
  geodata_api_sdk: 1.0.0
```

### Github
If this Dart package is published to Github, please include the following in pubspec.yaml
```yaml
dependencies:
  geodata_api_sdk:
    git:
      url: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
      #ref: main
```

### Local development
To use the package from your local drive, please include the following in pubspec.yaml
```yaml
dependencies:
  geodata_api_sdk:
    path: /path/to/geodata_api_sdk
```

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```dart
import 'package:geodata_api_sdk/geodata_api_sdk.dart';


final api = GeodataApiSdk().getDefaultApi();

try {
    final response = await api.buildingGet();
    print(response);
} catch on DioException (e) {
    print("Exception when calling DefaultApi->buildingGet: $e\n");
}

```

## Documentation for API Endpoints

All URIs are relative to *https://api.hmroomfinder.gosmroutify.xyz/v1*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
[*DefaultApi*](doc/DefaultApi.md) | [**buildingGet**](doc/DefaultApi.md#buildingget) | **GET** /building | Get Buildings
[*DefaultApi*](doc/DefaultApi.md) | [**doorGet**](doc/DefaultApi.md#doorget) | **GET** /door | Get Doors
[*DefaultApi*](doc/DefaultApi.md) | [**levelGet**](doc/DefaultApi.md#levelget) | **GET** /level | Get Levels
[*DefaultApi*](doc/DefaultApi.md) | [**reindexGet**](doc/DefaultApi.md#reindexget) | **GET** /reindex | Reindex the Search
[*DefaultApi*](doc/DefaultApi.md) | [**roomGet**](doc/DefaultApi.md#roomget) | **GET** /room | Get Rooms
[*DefaultApi*](doc/DefaultApi.md) | [**searchGet**](doc/DefaultApi.md#searchget) | **GET** /search | Search


## Documentation For Models

 - [Feature](doc/Feature.md)
 - [FeatureCollection](doc/FeatureCollection.md)
 - [FeatureGeometry](doc/FeatureGeometry.md)
 - [GeometryPoint](doc/GeometryPoint.md)
 - [GeometryPolygon](doc/GeometryPolygon.md)


## Documentation For Authorization

Endpoints do not require authorization.


## Author



