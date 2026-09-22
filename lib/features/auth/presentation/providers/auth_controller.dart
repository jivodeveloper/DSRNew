import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_providers.dart';

enum AuthStatus {
  loading,
  authenticated,
  unauthenticated,
}

class AuthController extends Notifier<AuthStatus> {

  @override
  AuthStatus build() {
    Future.microtask(checkSession);

    return AuthStatus.loading;
  }

  Future<void> checkSession() async {
    await Future<void>.delayed(
      const Duration(seconds: 2),
    );

    state = AuthStatus.unauthenticated;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    final authRepository = ref.read(authRepositoryProvider);
    final isValid = await authRepository.login(email: email, password: password);

    if (isValid) {
      state = AuthStatus.authenticated;
    }

    return isValid;
  }

  Future<void> logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.logout();
    state = AuthStatus.unauthenticated;
  }
  
  
}
