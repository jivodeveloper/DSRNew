import 'package:dio/dio.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/features/auth/data/models/user_dto.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource(this._dio);

  final Dio _dio;

  Future<UserDto> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/AndroidServer/LoginSalesPerson3',
        queryParameters: {'user': username, 'password': password},
      );

      final user = UserDto.fromJson(response.data ?? const {});

      if (user.personId == 0) {
        throw const InvalidCredentialsException();
      }

      return user;
    } on DioException catch (e) {
      final error = e.error;
      throw error is AppException
          ? error
          : UnknownException(e.message ?? 'Unknown error');
    }
  }
}
