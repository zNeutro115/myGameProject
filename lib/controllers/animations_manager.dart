import 'package:flutter/material.dart';

class AnimationsManager extends ChangeNotifier {
  double _heightAndWidth = 100;
  double get heightAndWidth => _heightAndWidth;
  set heightAndWidth(double value) {
    _heightAndWidth = value;
    notifyListeners();
  }
}
