import 'package:flutter/material.dart';
import 'package:survey/presentation/core/colors/colors.dart';

themeData(FacultyColor color) => ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: color.color),
    );
