import 'package:recipe_app/core/constants/api_constants.dart';
import 'package:recipe_app/core/network/api_client.dart';

import '../models/login_request_model.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl({required this._apiClient});

  @override
  Future<UserModel> login(LoginRequestModel request) async {
    return _apiClient.post<UserModel>(
      endpoint: ApiConstants.login,
      data: request.toJson(),
      converter: (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<UserModel> getCurrentUser() async {
    return _apiClient.get<UserModel>(
      endpoint: ApiConstants.currentUser,
      converter: (json) => UserModel.fromJson(json),
    );
  }
}
