import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

extension BoundsExtension on Feature {
  LatLngBounds? get bounds {
    final buildingBounds = bound.coordinates.asList();
    return LatLngBounds(
        southwest: LatLng(buildingBounds[0][0][1], buildingBounds[0][0][0]),
        northeast: LatLng(buildingBounds[0][2][1], buildingBounds[0][2][0]));
  }
}