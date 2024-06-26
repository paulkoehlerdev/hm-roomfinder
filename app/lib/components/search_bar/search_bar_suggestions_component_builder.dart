import 'dart:async';

import 'package:hm_roomfinder/api/geodata.dart';
import 'package:flutter/material.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';

class SearchBarSuggestionBuilder {

  final ValueSetter<Feature>? onSelect;

  const SearchBarSuggestionBuilder({this.onSelect});

  FutureOr<Iterable<Widget>> builder(BuildContext context, SearchController controller) async {
    final response = await GeodataRepository().search(controller.text);
    return response.data?.features.map((element) {
      return ListTile(
        title: Text(element.properties['name']?.asString ?? ''),
        onTap: () {
          onSelect?.call(element);
          controller.closeView(element.properties['name']?.asString ?? '');
        },
      );
    }) ?? [];
  }
}
