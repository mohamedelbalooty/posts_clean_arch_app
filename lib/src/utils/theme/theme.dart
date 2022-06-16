import 'package:flutter/material.dart';
import 'package:tdd_app/src/utils/theme/colors.dart';

class AppTheme {
  final ThemeData appTheme = ThemeData(
    primaryColor: mainClr,
    scaffoldBackgroundColor: whiteClr,
    appBarTheme: const AppBarTheme(
      backgroundColor: mainClr,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: whiteClr,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: mainClr,
    ),
  );
}
