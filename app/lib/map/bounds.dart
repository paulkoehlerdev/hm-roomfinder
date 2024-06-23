import 'package:maplibre_gl/maplibre_gl.dart';

extension Intersection on LatLngBounds {
  bool intersects(LatLngBounds other) {
    return !(this.southwest.latitude > other.northeast.latitude ||
        this.northeast.latitude < other.southwest.latitude ||
        this.southwest.longitude > other.northeast.longitude ||
        this.northeast.longitude < other.southwest.longitude);
  }
}
