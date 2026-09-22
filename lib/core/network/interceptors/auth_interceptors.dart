import 'package:dio/dio.dart';

class AuthInterceptors extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle the response if needed
    super.onResponse(response, handler);
  }
  
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Handle errors, e.g., token expiration
    super.onError(err, handler);
  }
  
}
