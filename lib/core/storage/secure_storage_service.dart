import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/storage_keys.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  Future<void> saveAccessToken(String token) {
    return _storage.write(key: StorageKeys.accessToken, value: token);
  }

  Future<void> saveRefreshToken(String token) {
    return _storage.write(key: StorageKeys.refreshToken, value: token);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: StorageKeys.accessToken);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: StorageKeys.refreshToken);
  }

  Future<void> deleteAccessToken() {
    return _storage.delete(key: StorageKeys.accessToken);
  }

  Future<void> deleteRefreshToken() {
    return _storage.delete(key: StorageKeys.refreshToken);
  }

  Future<void> clear() {
    return _storage.deleteAll();
  }

  Future<void> clearAuthTokens() {
    return Future.wait([deleteAccessToken(), deleteRefreshToken()]);
  }
}
