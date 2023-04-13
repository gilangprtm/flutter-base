import 'package:flutter/material.dart';

class MahasColors {
  static TextStyle muted = TextStyle(
    color: Colors.black.withOpacity(.3),
  );

  static const Color brown = Color(0xFFA66E68);
  static const Color cream = Color(0xFFF2C094);
  static const Color yellow = Color(0xFFffc145);
  static const Color red = Color(0xFFfb5454);
  static Color grey = Colors.black.withOpacity(.5);
  static const Color blueGrey = Color(0xFF78909C);
  static const Color orange = Color(0xFFdeaa20);
  static const Color darkwhite = Color(0xFFececec);
  static const Color green = Colors.green;
  static const Color backgroundColor = Colors.white;

  static const Color primary = red;
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color link = Colors.blue;
  static const Color danger = red;
  static const Color warning = yellow;

  static BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        MahasColors.cream.withOpacity(.8),
        MahasColors.cream,
      ],
    ),
  );
}
