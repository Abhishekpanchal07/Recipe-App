
import '../repositories/auth_repository_impl.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase({
    required this._repository,
  });

  Future<void> call() {
    return _repository.logout();
  }
}