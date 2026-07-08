import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';

import '../models/recipe_list_response_model.dart';
import '../models/recipe_model.dart';
import 'recipe_remote_data_source.dart';

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final ApiClient _apiClient;

  RecipeRemoteDataSourceImpl({required this._apiClient});

  @override
  Future<RecipeListResponseModel> getRecipes({
    required int skip,
    required int limit,
  }) {
    return _apiClient.get<RecipeListResponseModel>(
      endpoint: ApiConstants.recipes,
      queryParameters: {'skip': skip, 'limit': limit},
      converter: (data) =>
          RecipeListResponseModel.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<RecipeModel> getRecipe(int id) {
    return _apiClient.get<RecipeModel>(
      endpoint: '${ApiConstants.recipes}/$id',
      converter: (data) => RecipeModel.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<RecipeListResponseModel> searchRecipes({required String query}) {
    return _apiClient.get<RecipeListResponseModel>(
      endpoint: '${ApiConstants.recipes}/search',
      queryParameters: {'q': query},
      converter: (data) =>
          RecipeListResponseModel.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<List<String>> getTags() {
    return _apiClient.get<List<String>>(
      endpoint: '${ApiConstants.recipes}/tags',
      converter: (data) => List<String>.from(data as List),
    );
  }

  @override
  Future<RecipeListResponseModel> getRecipesByTag({required String tag}) {
    return _apiClient.get<RecipeListResponseModel>(
      endpoint: '${ApiConstants.recipes}/tag/$tag',
      converter: (data) =>
          RecipeListResponseModel.fromJson(data as Map<String, dynamic>),
    );
  }
}
