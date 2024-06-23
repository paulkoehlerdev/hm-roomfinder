import 'package:app/components/icons/hm_logo.dart';
import 'package:app/components/search_bar/search_bar_leading_icon.dart';
import 'package:flutter/material.dart';

class SearchInputComponentBuilder {
  static Widget builder(BuildContext context, SearchController controller) {
    FocusScope.of(context).unfocus();

    return SearchBar(
      controller: controller,
      padding: const MaterialStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16.0)),
      onTap: () {
        controller.openView();
      },
      onChanged: (_) {
        controller.openView();
      },
      hintText: 'Search for a location',
      leading: const SearchBarLeadingIcon(),
      trailing: const <Widget>[
        Tooltip(
          message: 'HM-Roomfinder',
          child: HmLogoIcon(),
        )
      ],
    );
  }
}
