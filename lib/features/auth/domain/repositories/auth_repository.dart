import 'package:jivodsr/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  
  User? get currentUser;

  Future<bool> hasSession();

  Future<void> login({required String username, required String password});

  Future<void> logout();
}
