import 'app_exception.dart';

class UnknownException extends AppException {
  const UnknownException({
    String message = 'Something went wrong. Please try again.',
  }) : super(message);
}