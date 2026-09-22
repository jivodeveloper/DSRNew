import 'package:jivodsr/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  
  bool _isLoggedIn = false;

  @override
  Future<bool> hasSession() async {
    await Future<void>.delayed(
      const Duration(seconds: 2),
    );
    return _isLoggedIn;
  }
  
  @override
  Future<bool> login({required String email, required String password}) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    final _isValid = email.trim().isNotEmpty && password.isNotEmpty;

    if (_isValid) {
      _isLoggedIn = true;
      return true;
    } else {
      _isLoggedIn = false;
      return false;
    }
  }
  
  @override
  Future<void> logout() async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
    _isLoggedIn = false;
  }
  
}