import 'package:flutter/material.dart';

import '../mahas_colors.dart';

class MahasThemes {
  static double borderRadius = 10;

  static ThemeData light = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: false,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(88, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        backgroundColor: MahasColors.primary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(88, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    ),
    appBarTheme:  AppBarTheme(
      backgroundColor: MahasColors.primary,
    ),
  );

  static TextStyle welcomeTitle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: MahasColors.light,
  );
  static TextStyle welcomeBody = const TextStyle(
    fontSize: 16,
    color: MahasColors.light,
  );

  static TextStyle h1 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle h2 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle h3 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle primaryH3 =  TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: MahasColors.primary,
  );
  static TextStyle h3White = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: MahasColors.light,
  );

  static TextStyle normal = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle normalWhite = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: MahasColors.light,
  );
  static TextStyle normalPrimary =  TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: MahasColors.primary,
  );

  static InputDecoration? textFiendDecoration({
    hintText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
    );
  }

  static TextStyle muted = TextStyle(
    color: MahasColors.dark.withOpacity(.5),
    fontSize: 12,
  );
  static TextStyle mutedH3 = TextStyle(
    color: MahasColors.dark.withOpacity(.5),
    fontSize: 14,
  );

  static TextStyle link = const TextStyle(
    color: MahasColors.link,
    fontSize: 12,
  );
}
