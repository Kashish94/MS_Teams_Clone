import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme;

  ThemeData get getTheme => _theme;

  setTheme(theme) {
    _theme = theme;
    notifyListeners();
  }
}
