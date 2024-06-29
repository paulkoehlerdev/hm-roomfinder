
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class CurrentLocationProvider extends ChangeNotifier {
  LatLng? _currentLocation;
  bool _tracking = false;

  bool get tracking => _tracking;

  set tracking(bool value) {
    _tracking = value;
    notifyListeners();
  }

  LatLng? get currentLocation => _currentLocation;

  set currentLocation(LatLng? value) {
    print("currentLocation: $value, tracking: $_tracking");
    _currentLocation = value;
    notifyListeners();
  }
}