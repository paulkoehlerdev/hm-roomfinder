import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

ThemeMode getThemeMode() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = getThemeMode();

  void toggleTheme(ThemeMode newMode) {
    themeMode = newMode;
    notifyListeners();
  }
}