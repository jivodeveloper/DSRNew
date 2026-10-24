import 'package:jivodsr/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:jivodsr/features/auth/domain/entities/user.dart';
import 'package:jivodsr/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  AuthRepositoryImpl(this._remote);
  
  User? _currentUser;
  final AuthRemoteDatasource _remote;
  
  @override
  User? get currentUser => _currentUser;
  
  @override
  Future<bool> hasSession() async => _currentUser != null;

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    final dto = await _remote.login(username: username, password: password);
    final user = dto.toEntity();
    _currentUser = user;
    
    return user;
  }

  @override
  Future<void> logout() async => _currentUser = null;

}
