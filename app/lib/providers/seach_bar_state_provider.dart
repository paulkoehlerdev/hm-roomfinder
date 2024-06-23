import 'package:flutter/material.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class SearchBarStateProvider extends ChangeNotifier {
  Feature? _selectedFeature;

  Feature? get selectedFeature => _selectedFeature;

  SearchBarStateProvider();

  void setSelectedFeature(Feature? feature) {
    _selectedFeature = feature;
    notifyListeners();
  }
}