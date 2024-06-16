import 'package:flutter/material.dart';

class UpdateLevelProvider extends ChangeNotifier {
  int currentLevel = 0;

  void updateLevel(int index) {
    currentLevel = index;
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