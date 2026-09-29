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
   return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => const RequestTimeoutException(),
    DioExceptionType.connectionError => const NetworkException(),
    DioExceptionType.badResponse => _mapResponse(e.response),
    DioExceptionType.cancel => const UnknownException('Request cancelled'),
    _ => UnknownException(e.message ?? 'Unknown error'),
   };
  }

  AppException _mapResponse(Response<dynamic>? response) {
   final code = response?.statusCode;
   if (code == 401) return const UnauthorizedException();
   return ServerException(
    response?.statusMessage ?? 'Server error',
    statusCode: code,
   );
  }

}
