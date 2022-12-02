import 'package:flutter/material.dart';

abstract class AppColor {
  static const int _primaryValue = 0xFF7AB678;
  static const Color primary = Color(_primaryValue);
  static const Color danger = Color(0xFFFF4B00);
  static const Color textMain = Colors.black;
  static const Color textGray = Color(0xFF444444);
  static const Color lightGray = Color(0xFFEAEAEA);
  static const Color secondaryBackground = Color(0xFFE8EBED);

  static const MaterialColor primaryMaterialColor =
      MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFEFF6EF),
    100: Color(0xFFD7E9D7),
    200: Color(0xFFBDDBBC),
    300: Color(0xFFA2CCA1),
    400: Color(0xFF8EC18C),
    500: primary,
    600: Color(0xFF72AF70),
    700: Color(0xFF67A665),
    800: Color(0xFF5D9E5B),
    900: Color(0xFF4A8E48),
  });
  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFEAFFEA),
    200: Color(_primaryAccentValue),
    400: Color(0xFF87FF84),
    700: Color(0xFF6EFF6A),
  });
  static const int _primaryAccentValue = 0xFFB9FFB7;
}
