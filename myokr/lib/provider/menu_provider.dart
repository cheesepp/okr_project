import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  int? _currentDrawer;
  int? get getCurrentDrawer => _currentDrawer;
  setCurrentDrawer(int? index) {
    _currentDrawer = index;
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldkey => _scaffoldKey;

  void openOrCloseDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
