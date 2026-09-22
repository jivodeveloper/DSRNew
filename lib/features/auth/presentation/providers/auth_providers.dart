import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:jivodsr/features/auth/domain/repositories/auth_repository.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_controller.dart';

final authControllerProvider = NotifierProvider<AuthController,AuthStatus>(
    AuthController.new,
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});



