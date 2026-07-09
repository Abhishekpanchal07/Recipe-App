import 'package:dio/dio.dart';

import '../../error/network_exception.dart';
import '../../error/server_exception.dart';
import '../../error/unauthorized_exception.dart';
import '../../error/unknown_exception.dart';

class DioExceptionHandler {
  const DioExceptionHandler._();

  static Exception handle(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _handleStatusCode(exception);

      case DioExceptionType.cancel:
        return const UnknownException(
          message: 'Request was cancelled.',
        );

      case DioExceptionType.badCertificate:
        return const UnknownException(
          message: 'Invalid server certificate.',
        );

      case DioExceptionType.transformTimeout:
        return const UnknownException(
          message: 'Response transformation timed out.',
        );

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const UnknownException();
    }
  }

  static Exception _handleStatusCode(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final response = exception.response?.data;

    String? message;

    if (response is Map<String, dynamic>) {
      message = response['message'] as String?;
    }

    switch (statusCode) {
      case 400:
        return UnknownException(
          message: message ?? 'Bad request.',
        );

      case 401:
        return UnauthorizedException(
          message: message ?? 'Unauthorized.',
        );

      case 500:
      case 502:
      case 503:
        return ServerException(
          message: message ?? 'Server error.',
        );

      default:
        return UnknownException(
          message: message ?? 'Something went wrong.',
        );
    }
  }
}