import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:latlong2/latlong.dart';

extension BoundsExtension on Feature {
  LatLngBounds? get bounds {
    final buildingBounds = bound.coordinates.asList();
    return LatLngBounds(
        LatLng(buildingBounds[0][0][1], buildingBounds[0][0][0]),
        LatLng(buildingBounds[0][2][1], buildingBounds[0][2][0]));
  }
}