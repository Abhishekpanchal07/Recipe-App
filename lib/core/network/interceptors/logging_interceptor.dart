import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger _logger;

  LoggingInterceptor({required this._logger});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('''
🌍 REQUEST
METHOD : ${options.method}
URL    : ${options.uri}
HEADERS: ${options.headers}
QUERY  : ${options.queryParameters}
BODY   : ${options.data}
''');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('''
✅ RESPONSE
STATUS : ${response.statusCode}
URL    : ${response.requestOptions.uri}
DATA   : ${response.data}
''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('''
❌ ERROR
STATUS : ${err.response?.statusCode}
URL    : ${err.requestOptions.uri}
MESSAGE: ${err.message}
DATA   : ${err.response?.data}
''');

    handler.next(err);
  }
}
