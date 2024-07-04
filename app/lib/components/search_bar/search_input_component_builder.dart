import 'package:flutter/widgets.dart';
import 'package:hm_roomfinder/components/icons/hm_logo.dart';
import 'package:hm_roomfinder/components/search_bar/search_bar_leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:hm_roomfinder/settings_view.dart';

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
      trailing: <Widget>[
        Tooltip(
          message: 'HM-Roomfinder',
          child: InkWell(
            child: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            }
          )
        )
      ],
    );
  }
}
