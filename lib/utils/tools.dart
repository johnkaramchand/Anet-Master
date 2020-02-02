import 'package:flutter/material.dart';

class Tools {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static List<Color> multiColors = [
    Colors.red,
    Colors.amber,
    Colors.green,
    Colors.blue,
    Color.fromRGBO(97, 226, 171, 1),
    Color.fromRGBO(20, 20, 20, 1),
  ];
}
