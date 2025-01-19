import 'package:flutter/material.dart';

class AppColorExtension extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  AppColorExtension(final String hexColor) : super(_getColorFromHex(hexColor));
}
