
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier{

  ThemeMode _themeMode = ThemeMode.light;

  ThemeManager._();

  static ThemeManager instance = ThemeManager._();

  ThemeMode get themeMode => _themeMode;

  toogleTheme(bool isDark) {

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

  }

}