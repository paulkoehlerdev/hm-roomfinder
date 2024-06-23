import 'package:app/api/geodata.dart';
import 'package:app/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class LevelProvider extends ChangeNotifier {
  FeatureCollection? _currentLevels;
  int? _currentBuildingId;
  int? _currentLevelId;

  int? get currentLevelId => _currentLevelId;

  List<Polygon> get polygons {
    if (_currentLevels == null) {
      return [];
    }
    return _currentLevels!.features.map((feature) => feature.polygon).toList();
  }

  Map<int, String> get levelIds {
    if (_currentLevels == null) {
      return {};
    }

    return Map.fromEntries(_currentLevels!.features
        .map((feature) {
      return MapEntry(feature.id, feature.name);
    }));
  }

  Map<String, int> get levelNames {
    if (_currentLevels == null) {
      return {};
    }

    return Map.fromEntries(_currentLevels!.features
        .map((feature) {
      return MapEntry(feature.name, feature.id);
    }));
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
    _currentLevelId = value.data!.features[0].id;
    notifyListeners();
  }

  void selectLevel(int levelId) {
    _currentLevelId = levelId;
    notifyListeners();
  }

  Future<void> clearLevels() async {
    _currentLevels = null;
    _currentLevelId = null;
    _currentBuildingId = null;
    notifyListeners();
  }
}
