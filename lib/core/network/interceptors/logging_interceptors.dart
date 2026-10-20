import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptors extends LogInterceptor {
  LoggingInterceptors()
    : super(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      );

  bool _isLogin(RequestOptions options) =>
      options.path == '/AndroidServer/LoginSalesPerson3';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isLogin(options)) {
      handler.next(options);
      return;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_isLogin(response.requestOptions)) {
      handler.next(response);
      return;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_isLogin(err.requestOptions)) {
      handler.next(err);
      return;
    }
    super.onError(err, handler);
  }
}
