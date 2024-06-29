import 'package:flutter/foundation.dart';
import 'package:hm_roomfinder/api/bounds_extension.dart';
import 'package:hm_roomfinder/api/geodata.dart';
import 'package:hm_roomfinder/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:latlong2/latlong.dart';

class RoomProvider extends ChangeNotifier {
  List<Feature>? _currentRooms;
  List<int>? _currentLevelId;

  List<Polygon> get polygons {
    if (_currentRooms == null) {
      return [];
    }
    return _currentRooms!.map((feature) => feature.polygon).toList();
  }

  Map<String, LatLng> get roomNames {
    if (_currentRooms == null) {
      return {};
    }

    return Map.fromEntries(_currentRooms!.map((feature) {
      return MapEntry(feature.name, feature.bounds!.center);
    }));
  }

  void loadRooms(List<int> levelId) {
    if (listEquals(_currentLevelId, levelId)) {
      return;
    }

    _currentLevelId = levelId;
    notifyListeners();

    print("Loading rooms");

    Future.wait(levelId.map((e) => GeodataRepository().roomGet(e)))
        .then((levels) {
      _currentRooms = [];
      for (var level in levels) {
        _currentRooms!.addAll(level.data!.features);
      }
      notifyListeners();
    });
  }

  void clearRooms() {
    _currentRooms = null;
    _currentLevelId = null;
    notifyListeners();
  }
}
