import 'package:flutter/material.dart';
import 'package:yad_sys/tools/app_cache.dart';

class ThemeProvider extends ChangeNotifier {
  AppCache cache = AppCache();
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    getTheme();
  }

  set themeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        {
          cache.setString('theme', 'system');
          _themeMode = ThemeMode.system;
          break;
        }
      case ThemeMode.light:
        {
          cache.setString('theme', 'light');
          _themeMode = ThemeMode.light;
          break;
        }
      case ThemeMode.dark:
        {
          cache.setString('theme', 'dark');
          _themeMode = ThemeMode.dark;
          break;
        }
    }
    notifyListeners();
  }

  getTheme() async {
    String theme = await cache.getString('theme') ?? "system";
    switch (theme) {
      case "system":
        {
          _themeMode = ThemeMode.system;
          break;
        }
      case "light":
        {
          _themeMode = ThemeMode.light;
          break;
        }
      case "dark":
        {
          _themeMode = ThemeMode.dark;
          break;
        }
    }
    notifyListeners();
  }
}
