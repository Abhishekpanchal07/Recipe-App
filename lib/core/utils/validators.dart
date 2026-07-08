import 'package:recipe_app/core/constants/app_strings.dart';

final class Validators {
  const Validators._();

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.usernameRequired;
    }

    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.trim())) {
      return AppStrings.invalidUsername;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }

    if (value.length < 6) {
      return AppStrings.passwordMinLength;
    }

    return null;
  }
}