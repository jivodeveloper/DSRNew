import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/network/dio_client.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_providers.dart';
import 'package:jivodsr/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:jivodsr/features/dashboard/data/repositories/dashboard_repo_impl.dart';
import 'package:jivodsr/features/dashboard/domain/entities/dashboard_progress.dart';
import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';
import 'package:jivodsr/features/dashboard/domain/repositories/dashboard_repository.dart';

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((
  ref,
) {
  return DashboardRemoteDataSource(ref.watch(dioProvider));
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepoImpl(ref.watch(dashboardRemoteDataSourceProvider));
});

// final userDetailsProvider = FutureProvider<UserDetails>((ref) async {

//   final user = ref.watch(authRepositoryProvider).currentUser;

//   if (user == null) {
//     throw const UnauthorizedException();
//   }

//   return ref.watch(dashboardRepositoryProvider).getDetailsById(user.id);

// });

// final userDetailsProvider =
//     FutureProvider.autoDispose<UserDetails>((ref) async {
//   final status = ref.watch(authControllerProvider);

//   if (status != AuthStatus.authenticated) {
//     throw const UnauthorizedException();
//   }

//   return ref.watch(dashboardRepositoryProvider).getDetailsById();
// });

final userDetailsProvider = FutureProvider<UserDetails>((ref) async {
  ref.watch(authControllerProvider);

  return ref.watch(dashboardRepositoryProvider).getDetailsById();
});

final dashboardProgressProvider = FutureProvider.autoDispose
    .family<DashboardProgress, ProgressPeriod>((ref, period) async {
      await Future.delayed(const Duration(milliseconds: 400));

      final now = DateTime.now();
      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

      return switch (period) {
        ProgressPeriod.today => const DashboardProgress(
          period: ProgressPeriod.today,
          target: 650,
          shopsCovered: 12,
          shopsPlanned: 24,
          productiveCalls: 2,
          productiveTarget: 8,
        ),
        ProgressPeriod.month => DashboardProgress(
          period: ProgressPeriod.month,
          target: 17000,
          shopsCovered: 102,
          shopsPlanned: 316,
          productiveCalls: 9,
          productiveTarget: 200,
          dayOfMonth: now.day,
          daysInMonth: daysInMonth,
        ),
      };
    });
