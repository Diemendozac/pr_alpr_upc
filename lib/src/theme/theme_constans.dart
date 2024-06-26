import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const lightBackgroundColor = Colors.white;
const lightOnBackgroundColor = Color.fromRGBO(25, 35, 66, 1);
const lightPrimaryColor = Color.fromRGBO(86, 125, 244, 1);
const lightOnPrimaryColor = Colors.white;
const lightSecundaryColor = Color.fromRGBO(255, 49, 123, 1);
const lightOnSecundaryColor = Colors.white;
const lightFocusColor = lightSecundaryColor;
const lightErrorColor = Color.fromRGBO(244, 67, 54, 1);
const lightOnErrorColor = Colors.white;
const lightSurfaceColor = Color.fromRGBO(243, 246, 255, 1);
const lightOnSurfaceColor = Color.fromRGBO(103, 113, 145, 1);
const lightTitleColor = Color.fromRGBO(25, 35, 66, 1);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Lato',
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    background: lightBackgroundColor,
    onBackground: lightOnBackgroundColor,
    primary: lightPrimaryColor,
    onPrimary: lightOnPrimaryColor,
    secondary: lightSecundaryColor,
    onSecondary: lightSecundaryColor,
    surface: lightSurfaceColor,
    onSurface: lightOnSurfaceColor,
    error: lightErrorColor,
    onError: lightOnErrorColor,
  ),
  textTheme: TextTheme(
    titleSmall: _titleFontBuilder(18.0, lightTitleColor),
    titleMedium: _titleFontBuilder(24.0, lightTitleColor),
    titleLarge: _titleFontBuilder(32.0, lightTitleColor),
  ),

);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);

TextStyle _titleFontBuilder(double size, Color fontColor) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: size,
    color: fontColor
  );
}