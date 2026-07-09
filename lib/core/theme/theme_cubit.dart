import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../storage/app_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final AppPreferences _preferences;

  ThemeCubit({required AppPreferences preferences})
    : _preferences = preferences,
      super(ThemeState(themeMode: preferences.getThemeMode()));

  /*   Future<void> setTheme(ThemeMode mode) async {
    await _preferences.saveThemeMode(mode);

    emit(
      state.copyWith(
        themeMode: mode,
      ),
    );
  } */
  Future<void> setTheme(ThemeMode mode) async {
    debugPrint('Before emit: ${state.themeMode} -> $mode');

    emit(state.copyWith(themeMode: mode));

    debugPrint('After emit: ${state.themeMode}');

    await _preferences.saveThemeMode(mode);
  }

  Future<void> toggleTheme() async {
    final mode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await setTheme(mode);
  }
}
