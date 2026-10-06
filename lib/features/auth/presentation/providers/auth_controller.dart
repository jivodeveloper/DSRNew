import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_providers.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    Future.microtask(checkSession);
    return AuthStatus.loading;
  }

  Future<void> checkSession() async {
    final hasSession = await ref.read(authRepositoryProvider).hasSession();
    state = hasSession ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  Future<void> login({required String email, required String password}) async {
    await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.logout();
    state = AuthStatus.unauthenticated;
  }
}
