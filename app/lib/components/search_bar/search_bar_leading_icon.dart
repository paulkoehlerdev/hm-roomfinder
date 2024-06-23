import 'package:app/providers/seach_bar_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarLeadingIcon extends StatelessWidget {
  const SearchBarLeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarStateProvider>(
      builder:
          (BuildContext context, SearchBarStateProvider value, Widget? child) {
        return InkWell(
          onTap: value.selectedFeature != null ? () {
            value.setSelectedFeature(null);
          } : null,
          child:
              Icon(value.selectedFeature == null ? Icons.search : Icons.clear),
        );
      },
    );
  }
}
