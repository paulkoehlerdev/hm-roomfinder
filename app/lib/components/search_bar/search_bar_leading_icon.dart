import 'package:flutter_svg/svg.dart';
import 'package:hm_roomfinder/providers/seach_bar_state_provider.dart';
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
          onTap: value.selectedFeature != null
              ? () {
                  value.setSelectedFeature(null);
                }
              : null,
          child: value.selectedFeature != null
              ? const Icon(Icons.close)
              : SvgPicture.asset('assets/logo.svg'),
        );
      },
    );
  }
}
