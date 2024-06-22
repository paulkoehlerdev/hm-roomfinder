import 'package:flutter/material.dart';

class UpdateLevelProvider extends ChangeNotifier {
  int currentLevel = 0;
  List availableLevels = [];

  void updateLevel(int index) {
    currentLevel = index;
    notifyListeners();
  }

  void setAvailableLevels(List levels) {
    availableLevels = levels;
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