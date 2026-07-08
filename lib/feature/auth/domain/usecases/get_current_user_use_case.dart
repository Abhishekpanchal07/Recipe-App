import '../entites/user.dart';
import '../repositories/auth_repository_impl.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase({required this._repository});

  Future<User> call() {
    return _repository.getCurrentUser();
  }
}
