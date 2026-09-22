abstract interface class AuthRepository{
    
    Future<bool> hasSession();

    Future<bool> login({required String email,required String password});

    Future<void> logout();

}