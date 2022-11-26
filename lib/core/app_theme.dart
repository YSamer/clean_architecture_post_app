import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 48, 28, 162);
const Color secondryColor = Color(0xFF51A2EE);

final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    centerTitle: true,
  ),
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(primary: primaryColor),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: secondryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: primaryColor),
    iconColor: secondryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: secondryColor),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
