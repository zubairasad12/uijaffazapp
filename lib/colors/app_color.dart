import 'package:flutter/material.dart';

class AppColor {
  // default color
  static ValueNotifier<Color> primaryColor =
      ValueNotifier<Color>(Colors.deepOrange);

  // color change function
  static void changeColor(Color color) {
    primaryColor.value = color;
  }
}
