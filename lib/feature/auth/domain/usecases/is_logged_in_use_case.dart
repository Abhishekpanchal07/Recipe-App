
import '../repositories/auth_repository_impl.dart';

class IsLoggedInUseCase {
  final AuthRepository _repository;

  IsLoggedInUseCase({
    required this._repository,
  });

  Future<bool> call() {
    return _repository.isLoggedIn();
  }
}