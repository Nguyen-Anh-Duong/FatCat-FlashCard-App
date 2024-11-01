import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ScreenControlViewModel extends ChangeNotifier {
  late PersistentTabController controller;
  bool isBottomBarVisible = true;

  ScreenControlViewModel() {
    controller = PersistentTabController();
  }

  void hideBottomBar() {
    isBottomBarVisible = false;
    notifyListeners();
  }

  void showBottomBar() {
    isBottomBarVisible = true;
    notifyListeners();
  }
}
