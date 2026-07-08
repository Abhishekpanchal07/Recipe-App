import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/interceptors/auth_interceptor.dart';
import 'package:recipe_app/core/network/interceptors/logging_interceptor.dart';

import '../constants/api_constants.dart';
import '../constants/api_headers.dart';

class DioClient {
  final LoggingInterceptor _loggingInterceptor;
  final AuthInterceptor _authInterceptor;

  late final Dio dio;
  late final Dio tokenRefreshDio;

  DioClient({
    required this._loggingInterceptor,
    required this._authInterceptor,
  }) {
    _initializeDio();
  }

  void _initializeDio() {
    dio = _createBaseDio();

    dio.interceptors.addAll([
      _loggingInterceptor,
      _authInterceptor,
    ]);

    tokenRefreshDio = _createBaseDio();

    tokenRefreshDio.interceptors.add(
      _loggingInterceptor,
    );
  }

  Dio _createBaseDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          ApiHeaders.contentType: ApiHeaders.applicationJson,
          ApiHeaders.accept: ApiHeaders.applicationJson,
        },
      ),
    );
  }
}