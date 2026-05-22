import 'package:flutter/material.dart';

class GridStyleController extends ChangeNotifier {
  bool _gridStyle = true;
  bool get gridStyle => _gridStyle;

  void toggleGridStyle() {
    _gridStyle = !_gridStyle;
    notifyListeners();
  }
}
