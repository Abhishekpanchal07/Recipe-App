import '../models/login_request_model.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequestModel request);

  Future<UserModel> getCurrentUser();
}