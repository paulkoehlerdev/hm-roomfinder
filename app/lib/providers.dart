import 'package:flutter/material.dart';

class UpdateLevelProvider extends ChangeNotifier {
  int currentLevel = 0;
  List availableLevels = [];

  void updateLevel(int index) {
    currentLevel = index;
    notifyListeners();
  }

  void setAvailableLevels(List levels) {
    // build a list of levels with the same name sorted after level_id and add it to availableLevels
    // availableLevels = [[{eg_b0}, {eg_b1}], [{1og_b0}, {1og_b1}]]
    availableLevels.clear();
    levels.sort((a, b) => a['level_id'].compareTo(b['level_id']));
    List includedLevels = [];
    for (Map sourceLevel in levels) {
      List sameLevel = [];
      for (Map level in levels) {
        if (!includedLevels.contains(level['level_id'])) {
          if (level['level_name'] == sourceLevel['level_name']) {
            sameLevel.add(level);
            includedLevels.add(level['level_id']);
          }
        }
      }
      availableLevels.add(sameLevel);
    }
    notifyListeners();
  }
}

class ZoomLevelProvider extends ChangeNotifier {
  bool zoomLevel = false;

  void updateZoomLevel(bool zoom) {
    zoomLevel = zoom;
    notifyListeners();
  }
}