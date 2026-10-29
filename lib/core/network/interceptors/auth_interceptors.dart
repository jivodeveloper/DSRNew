import 'package:dio/dio.dart';
import 'package:jivodsr/core/storage/secure_storage.dart';

class AuthInterceptors extends Interceptor {
  
  AuthInterceptors(this._storage);

  final SecureStorageService _storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    
    try {
      final token = await _storage.getAccessToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      
      handler.next(options);
    } catch (error) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          message: 'Unable to read the saved token.',
        ),
      );
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle the response if needed
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle errors, e.g., token expiration
    super.onError(err, handler);
  }
}
