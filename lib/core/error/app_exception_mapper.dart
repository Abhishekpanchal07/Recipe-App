import 'network_exception.dart';
import 'server_exception.dart';
import 'unauthorized_exception.dart';
import 'unknown_exception.dart';

final class AppExceptionMapper {
  const AppExceptionMapper._();

  static String map(Object error) {
    switch (error) {
      case NetworkException():
        return 'No internet connection';

      case UnauthorizedException():
        return 'Session expired. Please login again.';

      case ServerException():
        return 'Server is unavailable. Please try again later.';

      case UnknownException():
        return error.message;

      default:
        return 'Something went wrong';
    }
  }
}