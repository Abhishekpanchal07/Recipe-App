import 'app_exception.dart';

class CacheException extends AppException {
  const CacheException({
    String message = 'Failed to access cached data.',
  }) : super(message);
}