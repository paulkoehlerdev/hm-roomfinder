import 'package:hm_roomfinder/api/bounds_extension.dart';
import 'package:hm_roomfinder/api/geodata.dart';
import 'package:hm_roomfinder/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:latlong2/latlong.dart';

class RoomProvider extends ChangeNotifier {
  FeatureCollection? _currentRooms;
  int? _currentLevelId;

  List<Polygon> get polygons {
    if (_currentRooms == null) {
      return [];
    }
    return _currentRooms!.features.map((feature) => feature.polygon).toList();
  }

  Map<String, LatLng> get roomNames {
    if (_currentRooms == null) {
      return {};
    }

    return Map.fromEntries(_currentRooms!.features
        .map((feature) {
      return MapEntry(feature.name, feature.bounds!.center);
    }));
  }

  void loadRooms(int levelId) {
    if (_currentLevelId == levelId) {
      return;
    }

    _currentLevelId = levelId;
    notifyListeners();

    print("Loading rooms");
    GeodataRepository().roomGet(levelId).then((value) {
      _currentRooms = value.data;
      notifyListeners();
    });
  }

  void clearRooms() {
    _currentRooms = null;
    _currentLevelId = null;
    notifyListeners();
  }
}
