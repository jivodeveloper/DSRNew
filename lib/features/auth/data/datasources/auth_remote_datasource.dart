import 'package:dio/dio.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/features/auth/data/models/login_request_dto.dart';

class AuthRemoteDatasource {

  AuthRemoteDatasource(this._dio); 

  final Dio _dio;

  Future<LoginResponseDto> login({
    required String username,
    required String password,
  }) async {

    try {

      final response = await _dio.post<Map<String, dynamic>>(
        'auth/login/',
        // queryParameters: {'user': username, 'password': password},
        data:{
          'username':username,
          'password':password
        }
      );

      final user = LoginResponseDto.fromJson(response.data ?? const {});

      // if (user.personId <= 0) {
      //   throw const InvalidCredentialsException();
      // } 
        
      return user;

    } on DioException catch (e) {
      final error = e.error;
      throw error is AppException
          ? error
          : const UnknownException('Unable to log in. Please try again.');
    } on TypeError {
      throw const UnknownException( 
        'Unexpected login response from the server.',
      );
    }
    
  }

}
