import 'package:flutter/material.dart';

class DeviceSizeConfig {
  static double screenHeight;
  static double screenWidth;
  static double viewBottomInsets;
  static double longestSide;
  MediaQueryData _mediaQuery;

  init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    screenHeight = _mediaQuery.size.height;
    screenWidth = _mediaQuery.size.width;
    viewBottomInsets = _mediaQuery.viewInsets.bottom;
    longestSide = _mediaQuery.size.longestSide;
  }
}
