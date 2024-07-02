import 'package:flutter_test/flutter_test.dart';
import 'package:hm_roomfinder/main.dart';
import 'package:hm_roomfinder/providers/theme_provider.dart';
import 'package:hm_roomfinder/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hm_roomfinder/util/globals.dart' as globals;

void main() {
  testWidgets('Switch between dark and light theme', (WidgetTester tester) async {
    // Define the ThemeProvider
    final themeProvider = ThemeProvider();

    // Build the SettingsView within the ThemeProvider
    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => themeProvider,
        child: const MaterialApp(
          home: SettingsView(),
        ),
      ),
    );

    // Verify the initial theme is light
    expect(themeProvider.themeMode == ThemeMode.light, true);

    // Find the SwitchListTile
    final switchListTile = find.byType(SwitchListTile);

    // Verify the SwitchListTile is initially set to light mode (off)
    expect(tester.widget<SwitchListTile>(switchListTile).value, false);

    // Tap the SwitchListTile to turn on dark mode
    await tester.tap(switchListTile);
    await tester.pumpAndSettle(); // Rebuild the widget

    // Verify the theme has changed to dark mode
    expect(themeProvider.themeMode == ThemeMode.dark, true);
    expect(tester.widget<SwitchListTile>(switchListTile).value, true);

    // Tap the SwitchListTile to turn off dark mode
    await tester.tap(switchListTile);
    await tester.pumpAndSettle(); // Rebuild the widget

    // Verify the theme has changed back to light mode
    expect(themeProvider.themeMode == ThemeMode.light, true);
    expect(tester.widget<SwitchListTile>(switchListTile).value, false);
  });

  testWidgets('Golden test for theme switch', (WidgetTester tester) async {
    // Define the ThemeProvider
    final themeProvider = ThemeProvider();
    globals.testMode = true;

    // Build the MyApp with ThemeProvider
    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => themeProvider,
        child: const MyApp(),
      ),
    );

    // Verify the initial light theme
    await expectLater(
      find.byType(MyApp),
      matchesGoldenFile('goldens/myapp_light.png'),
    );

    // Wait for the widget to build right
    await tester.pumpAndSettle();
    
    // Navigate to SettingsView
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    // Verify the dark theme
    await expectLater(
      find.byType(MyApp),
      matchesGoldenFile('goldens/settings_view_light.png'),
    );

    // Find the SwitchListTile and toggle it to switch to dark theme
    final switchListTile = find.byType(SwitchListTile);
    await tester.tap(switchListTile);
    await tester.pumpAndSettle();

    // Verify the dark theme
    await expectLater(
      find.byType(MyApp),
      matchesGoldenFile('goldens/settings_view_dark.png'),
    );

    globals.testMode = false;
  });
}