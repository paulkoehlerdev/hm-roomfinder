import 'package:flutter/material.dart';

import 'hm_main_color.dart';

bool testMode = false;

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const HMMainColor(),
  ),
  useMaterial3: true,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const HMMainColor(),
    brightness: Brightness.dark,
  ),
);
