import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool isDarK) {
    _isDarkMode = isDarK;
    notifyListeners();
  }
}
