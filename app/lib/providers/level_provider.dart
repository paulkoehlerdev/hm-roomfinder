import 'package:hm_roomfinder/api/geodata.dart';
import 'package:hm_roomfinder/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class LevelProvider extends ChangeNotifier {
  FeatureCollection? _currentLevels;
  int? _currentBuildingId;
  int? _selectedLevelId; // Used to select a level after loading
  String? _currentLevelName = "EG";

  List<int>? get currentLevelId => levelNames[_currentLevelName];

  List<Polygon> get polygons {
    if (_currentLevels == null) {
      return [];
    }
    print('Getting polygons $_currentLevelName');
    return _currentLevels!.features
        .where((element) =>
            levelNames[_currentLevelName]?.contains(element.id) ?? false)
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

  selectLevelByLevelId(int levelId) {
    if (!levelIds.containsKey(levelId)) {
      _selectedLevelId = levelId;
      return;
    }

    _currentLevelName = levelIds[levelId];
    notifyListeners();
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

    if (_selectedLevelId != null) {
      _currentLevelName = levelIds[_selectedLevelId!];
      _selectedLevelId = null;
    }

    notifyListeners();
  }

  void selectLevel(String? name) {
    _currentLevelName = name;
    notifyListeners();
  }

  Future<void> clearLevels() async {
    _currentLevels = null;
    _currentBuildingId = null;
    notifyListeners();
  }
}
