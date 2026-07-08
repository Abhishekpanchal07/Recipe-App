import '../../../../core/storage/secure_storage_service.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/models/login_request_model.dart';
import '../entites/user.dart';

abstract interface class AuthRepository {
  Future<User> login({required String username, required String password});

  Future<User> getCurrentUser();

  Future<bool> isLoggedIn();

  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorageService;

  AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._secureStorageService,
  });

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    final user = await _remoteDataSource.login(
      LoginRequestModel(username: username, password: password),
    );

    await _secureStorageService.saveTokens(
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
    );

    return user;
  }

  @override
  Future<User> getCurrentUser() {
    return _remoteDataSource.getCurrentUser();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secureStorageService.getAccessToken();

    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> logout() async {
    await _secureStorageService.clear();
  }
}
