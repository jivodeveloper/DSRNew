sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Session expired. Please log in again.',
  ]);
}

class ServerException extends AppException {
  const ServerException(super.message, {this.statusCode});
  final int? statusCode;
}

class CacheException extends AppException {
  const CacheException([super.message = 'Could not read saved data.']);
}

class UnknownException extends AppException {
  const UnknownException([
    super.message = 'Something went wrong. Please try again.',
  ]);
}

class RequestTimeoutException extends AppException {
  const RequestTimeoutException([
    super.message = 'Request timed out. Please try again.',
  ]);
}

class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException([
    super.message = 'Invalid username or password',
  ]);
}
