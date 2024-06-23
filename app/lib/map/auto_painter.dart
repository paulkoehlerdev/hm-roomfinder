import 'package:app/map/layer_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract class AutoPainter<T extends ChangeNotifier> {

  final LayerManager manager;
  final T provider;

  AutoPainter({required T this.provider, required this.manager}) {
    provider.addListener(() {
      autoPaint(provider);
    });
    autoPaint(provider);
  }

  void autoPaint(T provider);
}