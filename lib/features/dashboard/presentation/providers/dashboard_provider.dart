import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/core/network/dio_client.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_providers.dart';
import 'package:jivodsr/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:jivodsr/features/dashboard/data/repositories/dashboard_repo_impl.dart';
import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';
import 'package:jivodsr/features/dashboard/domain/repositories/dashboard_repository.dart';

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  return DashboardRemoteDataSource(ref.watch(dioProvider));
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepoImpl(ref.watch(dashboardRemoteDataSourceProvider));
});

final userDetailsProvider = FutureProvider<UserDetails>((ref) async {

  final user = ref.watch(authRepositoryProvider).currentUser;

  if (user == null) {
    throw const UnauthorizedException();
  }
  
  return ref.watch(dashboardRepositoryProvider).getUserDetails(userId: user.id);

});
