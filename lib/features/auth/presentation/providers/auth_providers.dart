import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/network/dio_client.dart';
import 'package:jivodsr/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:jivodsr/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:jivodsr/features/auth/domain/repositories/auth_repository.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_controller.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource(ref.watch(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDatasourceProvider));
});

final authControllerProvider = NotifierProvider<AuthController, AuthStatus>(
  AuthController.new,
);
