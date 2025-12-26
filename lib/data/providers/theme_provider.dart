import 'package:flutter/material.dart';

enum AppThemeMode { light, dark }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _currentTheme = AppThemeMode.light;

  AppThemeMode get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme =
        _currentTheme == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
    notifyListeners();
  }

  ThemeMode get themeMode =>
      _currentTheme == AppThemeMode.light ? ThemeMode.light : ThemeMode.dark;
}
