import 'package:flutter/material.dart';

abstract class AppColor {
  static const int _primaryValue = 0xFF009144;
  static const Color primary = Color(_primaryValue);
  static const Color danger = Color(0xFFFF4B00);
  static const Color textMain = Colors.black;
  static const Color textLightGray = Color(0xFFE2E2E2);
  static const Color secondaryBackground = Color(0xFFE8EBED);

  static const MaterialColor primaryMaterialColor =
      MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFE0F2E9),
    100: Color(0xFFB3DEC7),
    200: Color(0xFF80C8A2),
    300: Color(0xFF4DB27C),
    400: Color(0xFF26A260),
    500: primary,
    600: Color(0xFF00893E),
    700: Color(0xFF007E35),
    800: Color(0xFF00742D),
    900: Color(0xFF00621F),
  });

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFF92FFAA),
    200: Color(_primaryAccentValue),
    400: Color(0xFF2CFF5A),
    700: Color(0xFF13FF47),
  });
  static const int _primaryAccentValue = 0xFF5FFF82;
}
