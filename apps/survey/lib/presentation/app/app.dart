import 'package:flutter/material.dart';
import 'package:survey/presentation/core/colors/colors.dart';
import 'package:survey/presentation/core/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HM Roomfinder Survey',
      debugShowCheckedModeBanner: false,
      theme: themeData(FacultyColor.hm),
    );
  }
}
