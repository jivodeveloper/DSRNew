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

final userDetailsProvider = FutureProvider<UserDetails>((ref) async {
  ref.watch(authControllerProvider);
  return ref.watch(dashboardRepositoryProvider).getDetailsById();
});

final dashboardProgressProvider = FutureProvider.autoDispose
    .family<DashboardProgress, ProgressPeriod>((ref, period) async {
      switch (period) {
        case ProgressPeriod.month:
          // Real data: month-to-date numbers come with /userDetails.
          final details = await ref.watch(userDetailsProvider.future);
          return DashboardProgress.monthFrom(details);

        case ProgressPeriod.today:
          // Fake until the backend has a "today" API.
          await Future.delayed(const Duration(milliseconds: 400));
          return const DashboardProgress(
            period: ProgressPeriod.today,
            target: 650,
            shopsCovered: 12,
            shopsPlanned: 24,
            productiveCalls: 2,
            productiveTarget: 8,
          );
      }
    });
