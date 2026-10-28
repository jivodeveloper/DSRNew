import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jivodsr/core/storage/secure_storage.dart';

final secureProviders = Provider<SecureStorageService>((ref){
  return SecureStorageService(const FlutterSecureStorage());
});
