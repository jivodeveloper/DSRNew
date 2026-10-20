import 'package:jivodsr/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<bool> hasSession();

  Future<User> login({required String username, required String password});

  Future<void> logout();
}
