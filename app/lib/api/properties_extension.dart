import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:latlong2/latlong.dart';

extension PropertiesExtension on Feature {
  int get id {
    return properties['id']!.asNum.toInt();
  }

  String get name {
    return properties['name']!.asString;
  }

  Polygon get polygon {
    switch (geometry.oneOf.valueType) {
      case GeometryPolygon:
        return Polygon(
          points: (geometry.oneOf.value as GeometryPolygon).coordinates[0].map(
            (point) {
              return LatLng(point[1], point[0]);
            }).toList(),
          hitValue: this,
          label: name,
        );
      default:
        throw Exception('Unknown type: ${geometry.oneOf.valueType}');
    }
  }
}
