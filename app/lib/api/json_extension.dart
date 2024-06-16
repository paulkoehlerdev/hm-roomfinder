import 'dart:ffi';

import 'package:geodata_api_sdk/geodata_api_sdk.dart';

extension JsonFeatureCollection on FeatureCollection {
  Map<String, dynamic> toJson() {
    return {
      'type': "FeatureCollection",
      'features': features.map((feature) => feature.toJson()).toList(),
    };
  }
}

extension JsonFeature on Feature {
  Map<String, dynamic> toJson() {
    return {
      'type': "Feature",
      'properties': properties.map((key, value) => MapEntry(key, value?.value)).toMap() as Map<String, dynamic>,
      'geometry': geometry.toJson(),
    };
  }
}

extension JsonFeatureGeometry on FeatureGeometry {
  Map<String, dynamic> toJson() {
    return switch (oneOf.valueType) {
      GeometryPoint => (oneOf.value as GeometryPoint).toJson(),
      GeometryPolygon => (oneOf.value as GeometryPolygon).toJson(),
      _ => throw Exception('Unknown type: $oneOf.valueType'),
    };
  }
}

extension JsonGeometryPoint on GeometryPoint {
  Map<String, dynamic> toJson() {
    return {
      'type': "Point",
      'coordinates': coordinates.toList(),
    };
  }
}

extension JsonGeometryPolygon on GeometryPolygon {
  Map<String, dynamic> toJson() {
    return {
      'type': "Polygon",
      'coordinates': coordinates.map((p0) => p0.map((p0) => p0.toList()).toList()).toList(),
    };
  }
}