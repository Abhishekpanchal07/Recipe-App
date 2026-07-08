import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _themeKey = 'theme_mode';

  final SharedPreferences _preferences;

  AppPreferences(this._preferences);

  ThemeMode getThemeMode() {
    final value = _preferences.getString(_themeKey);

    switch (value) {
      case 'light':
        return ThemeMode.light;

      case 'dark':
        return ThemeMode.dark;

      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) {
    return _preferences.setString(
      _themeKey,
      mode.name,
    );
  }
}