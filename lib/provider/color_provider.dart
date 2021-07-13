import 'package:flutter/material.dart';
import 'package:teams_clone/constants/onboard_page_data.dart';

class ColorProvider with ChangeNotifier {
  Color _color = onboardData[0].accentColor;

  Color get color => _color;

  setColor(Color color) {
    _color = color;
    notifyListeners();
  }
}
