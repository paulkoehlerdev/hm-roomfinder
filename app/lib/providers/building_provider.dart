import 'package:hm_roomfinder/api/bounds_extension.dart';
import 'package:hm_roomfinder/api/geodata.dart';
import 'package:hm_roomfinder/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class BuildingProvider extends ChangeNotifier {
  FeatureCollection? _buildings;

  BuildingProvider() {
    loadBuildings();
  }

  List<Polygon> get polygons {
    if (_buildings == null) {
      return [];
    }
    return _buildings!.features.map((feature) => feature.polygon).toList();
  }

  Map<int, LatLngBounds> get bounds {
    if (_buildings == null) {
      return {};
    }

    return Map.fromEntries(_buildings!.features.map((feature) {
      return MapEntry(feature.id, feature.bounds!);
    }));
  }

  Future<void> loadBuildings() async {
    print('Loading buildings');
    _buildings = (await GeodataRepository().buildingGet()).data;
    notifyListeners();
  }
}
