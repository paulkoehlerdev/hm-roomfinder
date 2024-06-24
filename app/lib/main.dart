import 'package:app/home_view.dart';
import 'package:app/providers/provider_initializer_component.dart';
import 'package:app/util/hm_main_color.dart';
import 'package:app/util/location_permission_requester.dart';
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
