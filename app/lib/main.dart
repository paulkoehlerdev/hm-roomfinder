import 'package:hm_roomfinder/home_view.dart';
import 'package:hm_roomfinder/providers/provider_initializer_component.dart';
import 'package:hm_roomfinder/util/globals.dart';
import 'package:hm_roomfinder/util/hm_main_color.dart';
import 'package:hm_roomfinder/util/location_permission_requester.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hm_roomfinder/providers/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const ProviderInitializerComponent(
        child: LocationPermissonRequester(
          child: HomeView(),
        ),
      ),
    );
  }
}
