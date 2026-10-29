import 'package:jivodsr/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';
import 'package:jivodsr/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepoImpl implements DashboardRepository {

  Map<String, dynamic>? _userDetails;

  Map<String, dynamic>? get userDetails => _userDetails;

  DashboardRepoImpl(
    this._remoteDataSource,
  );  

  final DashboardRemoteDataSource _remoteDataSource;

  @override
  Future<UserDetails> getDetailsById(int userId) {
    // TODO: implement getDetailsById
    throw UnimplementedError();
  }

  // @override
  // Future<UserDetails> getUserDetails({required int userId}) async {
  //   final dto = await _remoteDataSource.getUserDetails(userId: userId);
  //   return dto.toEntity();
  // }
  
}
