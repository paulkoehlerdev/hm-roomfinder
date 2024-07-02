import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hm_roomfinder/providers/theme_provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Dark mode'),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                if (value) {
                  themeProvider.toggleTheme(ThemeMode.dark);
                } else {
                  themeProvider.toggleTheme(ThemeMode.light);
                }
                  },
            ),
          ],
        ),
      ),
    );
  }
}