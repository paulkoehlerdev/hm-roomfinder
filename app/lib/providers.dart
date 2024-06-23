import 'package:flutter/material.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class VisibleGeodataProvider extends ChangeNotifier {
  final List<int> _visibleBuildings = [];
  final Map<int, Feature> _visibleLevels = {};

  final Map<int, int> _buildingLevels = {};
  final Map<String, List<int>> _availableLevels = {};
  String? _currentLevel;

  List<int> get visibleBuildings => List.unmodifiable(_visibleBuildings);
  List<int> get visibleLevels => List.unmodifiable(
      _availableLevels[_currentLevel] ?? []);

  List<String> get availableLevels => List.unmodifiable(_availableLevels.keys);

  String? get currentLevel => _currentLevel;

  bool get hasCurrentLevel => _currentLevel != null;

  Feature? getVisibleLayerGeom(int layerId) => _visibleLevels[layerId];

  void setCurrentLevel(String? level) {
    if (level == _currentLevel) {
      return;
    }

    _currentLevel = level;
    notifyListeners();
  }

  void addVisibleLayer(String name, int layerId, int buildingId, Feature layer) {
    if (!_availableLevels.containsKey(name)) {
      _availableLevels[name] = [];
    }
    _availableLevels[name]!.add(layerId);

    _buildingLevels[layerId] = buildingId;

    _visibleLevels[layerId] = layer;
    notifyListeners();
  }

  void removeVisibleLayer(int layerId) {
    if (!_visibleLevels.containsKey(layerId)) {
      return;
    }

    _visibleLevels.remove(layerId);
    notifyListeners();
  }


  bool addVisibleBuilding(int buildingId) {
    if (_visibleBuildings.contains(buildingId)) {
      return false;
    }

    _visibleBuildings.add(buildingId);
    notifyListeners();

    return true;
  }

  void removeVisibleBuilding(int buildingId) {
    if (!_visibleBuildings.contains(buildingId)) {
      return;
    }

    final levelsToRemove = _buildingLevels.entries
        .where((element) => element.value == buildingId)
        .map((e) => e.key)
        .toList();

    _visibleLevels.removeWhere((key, value) => levelsToRemove.contains(key));

    _availableLevels.forEach((key, value) => value.removeWhere((element) => levelsToRemove.contains(element)));
    _availableLevels.removeWhere((key, value) => value.isEmpty);

    _buildingLevels.removeWhere((key, value) => levelsToRemove.contains(key));

    _visibleBuildings.remove(buildingId);
    notifyListeners();
  }
}
