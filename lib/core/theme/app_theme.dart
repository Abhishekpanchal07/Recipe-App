import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

final class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.lightSurface,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: AppTextTheme.textTheme,
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: AppTextTheme.textTheme,
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(
    ColorScheme colorScheme,
  ) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: colorScheme.outline,
      ),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border: border,
      enabledBorder: border,

      focusedBorder: border.copyWith(
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 1.5,
        ),
      ),

      errorBorder: border.copyWith(
        borderSide: BorderSide(
          color: colorScheme.error,
        ),
      ),

      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 1.5,
        ),
      ),
    );
  }
}