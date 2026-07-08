 final class ApiConstants {
  const ApiConstants._();

  /// Base URL
  static const String baseUrl = 'https://dummyjson.com';

  /// Authentication
  static const String login = '/auth/login';
  static const String currentUser = '/auth/me';
  static const String refreshToken = '/auth/refresh';

  /// Recipes
  static const String recipes = '/recipes';

  /// Network Configuration
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}