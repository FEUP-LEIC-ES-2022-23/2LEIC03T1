import 'package:flutter/material.dart';

class ThemePreferences with ChangeNotifier{
  static var isDarkTheme;
  static ThemeMode _themeMode= ThemeMode.light;


  setTheme(bool isDark){
    _themeMode= isDark? ThemeMode.dark:ThemeMode.light;
    isDarkTheme=isDark;
    notifyListeners();
  }
  get themeMode => _themeMode;

  bool getTheme() {
    return isDarkTheme ?? false;
  }
}