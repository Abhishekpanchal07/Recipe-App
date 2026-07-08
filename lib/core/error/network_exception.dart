import 'app_exception.dart';

class NetworkException extends AppException {
  const NetworkException({
    String message = 'No internet connection. Please check your network and try again.',
  }) : super(message);
}