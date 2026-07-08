import 'package:dio/dio.dart';
import 'package:recipe_app/core/constants/api_constants.dart';

import '../../constants/api_headers.dart';
import '../../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;

  AuthInterceptor({required this._secureStorageService});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isPublicEndpoint =
        options.path == ApiConstants.login ||
        options.path == ApiConstants.refreshToken;

    if (isPublicEndpoint) {
      handler.next(options);
      return;
    }

    final accessToken = await _secureStorageService.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[ApiHeaders.authorization] =
          '${ApiHeaders.bearer} $accessToken';
    }

    handler.next(options);
  }
}
