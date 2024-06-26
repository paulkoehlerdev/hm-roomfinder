import 'package:hm_roomfinder/home_view.dart';
import 'package:hm_roomfinder/providers/provider_initializer_component.dart';
import 'package:hm_roomfinder/util/hm_main_color.dart';
import 'package:hm_roomfinder/util/location_permission_requester.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const HMMainColor(),
        ),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const HMMainColor(),
      //     brightness: Brightness.dark,
      //   ),
      // ),
      themeMode: ThemeMode.system,
      home: const LocationPermissonRequester(
        child: ProviderInitializerComponent(
          child: HomeView(),
        ),
      ),
    );
  }
}
