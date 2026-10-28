import 'package:jivodsr/core/storage/secure_storage.dart';
import 'package:jivodsr/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:jivodsr/features/auth/domain/entities/user.dart';
import 'package:jivodsr/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  AuthRepositoryImpl(this._remote,this._storage);
  
  User? _currentUser;
  final AuthRemoteDatasource _remote;
  final SecureStorageService _storage;

  @override
  User? get currentUser => _currentUser;

  Future<bool> hasSession() async{
    return _storage.hasAccessToken();
  }

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {

    final dto = await _remote.login(username: username, password: password);
    if(!dto.isValid){
      throw const FormatException('Login response did not contain and access token');
    }
    await _storage.saveTokens(accessToken:dto.access,refreshToken:dto.refresh);
    
  } 

  @override
  Future<void> logout() async{
    await _storage.deleteTokens();
    _currentUser = null;
  } 

}
