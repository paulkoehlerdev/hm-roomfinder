import 'package:app/api/geodata.dart';
import 'package:app/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class RoomProvider extends ChangeNotifier {
  FeatureCollection? _currentRooms;
  int? _currentLevelId;

  List<Polygon> get polygons {
    if (_currentRooms == null) {
      return [];
    }
    return _currentRooms!.features.map((feature) => feature.polygon).toList();
  }

  Map<String, int> get roomNames {
    if (_currentRooms == null) {
      return {};
    }

    return Map.fromEntries(_currentRooms!.features
        .where((feature) => feature.id == _currentLevelId)
        .map((feature) {
      return MapEntry(feature.name, feature.id);
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
