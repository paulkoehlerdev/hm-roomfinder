import 'package:app/api/properties_extension.dart';
import 'package:app/components/search_bar/search_bar_suggestions_component_builder.dart';
import 'package:app/components/search_bar/search_input_component_builder.dart';
import 'package:app/providers/polygon_touch_provider.dart';
import 'package:app/providers/seach_bar_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:geodata_api_sdk/geodata_api_sdk.dart';
import 'package:provider/provider.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {

  final SearchController _searchController = SearchController();

  _resetSearch() {
    if (Provider.of<SearchBarStateProvider>(context, listen: false).selectedFeature == null) {
      _searchController.clear();
    }
  }

  _handlePolygonTap() {
    final polygonTouchProvider = Provider.of<PolygonTouchProvider>(context, listen: false);
    final searchStateProvider = Provider.of<SearchBarStateProvider>(context, listen: false);

    if (polygonTouchProvider.feature != null) {
      searchStateProvider.setSelectedFeature(polygonTouchProvider.feature!);
      _searchController.text = polygonTouchProvider.feature!.name;
    } else {
      searchStateProvider.setSelectedFeature(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchBarStateProvider>(context, listen: true).addListener(_resetSearch);
    Provider.of<PolygonTouchProvider>(context, listen: true).addListener(_handlePolygonTap);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SearchAnchor(
            isFullScreen: false,
            viewHintText: 'Search for a location',
            searchController: _searchController,
            builder: SearchInputComponentBuilder.builder,
            suggestionsBuilder: SearchBarSuggestionBuilder(
              onSelect: (Feature feature) {
                Provider.of<SearchBarStateProvider>(context, listen: false)
                    .setSelectedFeature(feature);
              },
            ).builder,

          ),
        ),
      ),
    );
  }
}
