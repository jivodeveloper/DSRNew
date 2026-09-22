import 'dart:async';

import 'package:dio/dio.dart';
import 'package:jivodsr/core/error/app_exception.dart';

class ErrorInterceptor  extends Interceptor {
  
   @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _map(err),        
      ),
    );
  }

  AppException _map(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode ?? 0;
        if (code == 401 || code == 403) return const UnauthorizedException();
        return ServerException(
          e.response?.statusMessage ?? 'Server error',
          statusCode: code,
        );
      default:
        return UnknownException(e.message ?? 'Unknown error');
    }
  }

}
