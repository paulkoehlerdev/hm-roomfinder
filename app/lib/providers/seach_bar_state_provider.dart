import 'package:app/api/properties_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class SearchBarStateProvider extends ChangeNotifier {
  Feature? _selectedFeature;

  Feature? get selectedFeature => _selectedFeature;

  Polygon? get polygon => _selectedFeature?.polygon;

  SearchBarStateProvider();

  void setSelectedFeature(Feature? feature) {
    _selectedFeature = feature;
    notifyListeners();
  }
}