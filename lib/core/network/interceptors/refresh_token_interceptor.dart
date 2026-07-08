import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../constants/api_constants.dart';
import '../../storage/secure_storage_service.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio _mainDio;
  final Dio _tokenRefreshDio;
  final SecureStorageService _secureStorageService;
  final Logger _logger;

  RefreshTokenInterceptor({
    required this._mainDio,
    required this._tokenRefreshDio,
    required this._secureStorageService,
    required this._logger,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    try {
      final refreshToken = await _secureStorageService.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        await _secureStorageService.clear();
        handler.next(err);
        return;
      }

      final response = await _tokenRefreshDio.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': refreshToken, 'expiresInMins': 30},
      );

      final accessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      await _secureStorageService.saveTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      );

      final requestOptions = err.requestOptions;

      requestOptions.headers['Authorization'] = 'Bearer $accessToken';

      final retryResponse = await _mainDio.fetch(requestOptions);

      handler.resolve(retryResponse);
    } catch (e, stackTrace) {
      _logger.e('Token refresh failed', error: e, stackTrace: stackTrace);

      await _secureStorageService.clear();

      handler.next(err);
    }
  }
}
