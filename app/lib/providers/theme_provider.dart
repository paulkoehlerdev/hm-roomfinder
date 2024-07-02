import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme(ThemeMode newMode) {
    themeMode = newMode;
    notifyListeners();
  }
}