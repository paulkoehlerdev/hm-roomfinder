import 'package:hm_roomfinder/api/geodata.dart';
import 'package:hm_roomfinder/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class LevelProvider extends ChangeNotifier {
  FeatureCollection? _currentLevels;
  int? _currentBuildingId;
  List<int>? _currentLevelId;

  List<int>? get currentLevelId => _currentLevelId;

  List<Polygon> get polygons {
    if (_currentLevels == null) {
      return [];
    }
    return _currentLevels!.features
        .where((element) => _currentLevelId?.contains(element.id) ?? false)
        .map((feature) => feature.polygon)
        .toList();
  }

  Map<int, String> get levelIds {
    if (_currentLevels == null) {
      return {};
    }

    return Map.fromEntries(_currentLevels!.features.map((feature) {
      return MapEntry(feature.id, feature.name);
    }));
  }

  Map<String, List<int>> get levelNames {
    if (_currentLevels == null) {
      return {};
    }

    var map = <String, List<int>>{};

    for (var feature in _currentLevels!.features) {
      if (map.containsKey(feature.name)) {
        map[feature.name]!.add(feature.id);
      } else {
        map[feature.name] = [feature.id];
      }
    }

    return map;
  }

  Future<void> loadLevels(int buildingId) async {
    if (_currentBuildingId == buildingId) {
      return;
    }

    _currentBuildingId = buildingId;
    notifyListeners();

    print('Loading levels');
    final value = await GeodataRepository().levelGet(buildingId);

    _currentLevels = value.data;
    _currentLevelId = levelNames["EG"];
    notifyListeners();
  }

  void selectLevel(String? name) {
    if (name == null) {
      return;
    }

    _currentLevelId = levelNames[name];
    notifyListeners();
  }

  Future<void> clearLevels() async {
    _currentLevels = null;
    _currentLevelId = null;
    _currentBuildingId = null;
    notifyListeners();
  }
}
