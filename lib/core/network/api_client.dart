import 'package:dio/dio.dart';
import 'package:recipe_app/core/network/handler/dio_exception_handler.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required this._dio});

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
      throw DioExceptionHandler.handle(e);
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
      throw DioExceptionHandler.handle(e);
    }
  }

  Future<T> put<T>({
    required String endpoint,
    dynamic data,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.put(endpoint, data: data);

      return converter(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  Future<T> patch<T>({
    required String endpoint,
    dynamic data,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.patch(endpoint, data: data);

      return converter(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  Future<T> delete<T>({
    required String endpoint,
    dynamic data,
    required T Function(dynamic json) converter,
  }) async {
    try {
      final response = await _dio.delete(endpoint, data: data);

      return converter(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }
}
