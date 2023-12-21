
import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/services/locar_storage.dart';

class ThemeManager with ChangeNotifier{

  ThemeMode _themeMode = ThemeMode.light;

  ThemeManager._();

  static ThemeManager instance = ThemeManager._();

  ThemeMode get themeMode => _themeMode;

  toogleTheme(bool isDark) {

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    LocalStorage.prefs.setBool("themeMode", isDark);
    notifyListeners();

  }

}