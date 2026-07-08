import 'app_exception.dart';

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    String message = 'Your session has expired. Please log in again.',
  }) : super(message);
}