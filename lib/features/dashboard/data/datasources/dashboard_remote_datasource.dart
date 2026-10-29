import 'package:dio/dio.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/features/dashboard/data/models/user_details_dto.dart';

class DashboardRemoteDataSource {
  
  final Dio _dio;

  DashboardRemoteDataSource(this._dio);

  Future<UserDetailsDto> getUserDetails({
    required int userId,
  }) async {

    try {

     // final accessToken = await tokenStorage.readToken();
      final response = await _dio.get<Map<String, dynamic>>(
        '/userDetails/',
        options: Options(
          headers: {
            'Authorization':'Bearer $accessToken'
          }
        ),
        queryParameters: {'userId': userId},
      );
      
      final data = response.data;

      if (data == null || data.isEmpty) {
        throw const UnknownException('User details response is empty.');
      }
      
      return UserDetailsDto.fromJson(data);

    } on DioException catch (e) {

      final error = e.error;  

      if (error is AppException) {
        throw error;
      } 
      
      throw const UnknownException('Unable to load user details.');

    }

  }

}
