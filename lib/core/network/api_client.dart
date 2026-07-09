import 'package:dio/dio.dart';

import '../connectivity/connectivity_service.dart';
import '../error/network_exception.dart';
import '../error/unknown_exception.dart';
import 'handler/dio_exception_handler.dart';

class ApiClient {
  final Dio _dio;
  final ConnectivityService _connectivityService;

  ApiClient({
    required this._dio,
    required this._connectivityService,
  });

  Future<T> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      return converter(response.data);
    } on DioException catch (e) {
      throw await _handleException(e);
    }
  }

  Future<T> post<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      return converter(response.data);
    } on DioException catch (e) {
      throw await _handleException(e);
    }
  }

  Future<T> put<T>({
    required String endpoint,
    dynamic data,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
      );

      return converter(response.data);
    } on DioException catch (e) {
      throw await _handleException(e);
    }
  }

  Future<T> patch<T>({
    required String endpoint,
    dynamic data,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
      );

      return converter(response.data);
    } on DioException catch (e) {
      throw await _handleException(e);
    }
  }

  Future<T> delete<T>({
    required String endpoint,
    dynamic data,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
      );

      return converter(response.data);
    } on DioException catch (e) {
      throw await _handleException(e);
    }
  }

  Future<Exception> _handleException(DioException e) async {
    if (e.type == DioExceptionType.connectionError) {
      final isConnected = await _connectivityService.isConnected;

      if (!isConnected) {
        return const NetworkException();
      }

      return const UnknownException(
        message: 'Something went wrong.',
      );
    }

    return DioExceptionHandler.handle(e);
  }
}