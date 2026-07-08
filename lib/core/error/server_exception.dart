import 'app_exception.dart';

class ServerException extends AppException {
  const ServerException({
    String message = 'Something went wrong on our server. Please try again later.',
  }) : super(message);
}