import 'package:app/providers/seach_bar_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderInitializerComponent extends StatelessWidget {

  final Widget child;

  const ProviderInitializerComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchBarStateProvider()),
      ],
      child: child,
    );
  }
}