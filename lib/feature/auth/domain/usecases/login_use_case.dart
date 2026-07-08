import '../entites/user.dart';
import '../repositories/auth_repository_impl.dart';

import 'params/login_params.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase({
    required this._repository,
  });

  Future<User> call(LoginParams params) {
    return _repository.login(
      username: params.username,
      password: params.password,
    );
  }
}
