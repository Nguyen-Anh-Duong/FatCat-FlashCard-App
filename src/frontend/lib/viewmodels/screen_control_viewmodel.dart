import 'package:flutter/material.dart';

class ScreenControlViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setPage(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
