import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_list_response.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../data_source/recipe_local_data_source.dart';
import '../data_source/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource _remoteDataSource;
  final RecipeLocalDataSource _localDataSource;

  RecipeRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
  });

  @override
  Future<RecipeListResponse> getRecipes({
    required int skip,
    required int limit,
    bool forceRefresh = false,
  }) async {
    try {
      final response = await _remoteDataSource.getRecipes(
        skip: skip,
        limit: limit,
      );

      if (skip == 0) {
        await _localDataSource.clearRecipes();
      }

      await _localDataSource.saveRecipes(response.recipes);

      return response.toEntity();
    } catch (_) {
      final cachedRecipes = await _localDataSource.getRecipes();

      if (cachedRecipes.isNotEmpty) {
        return RecipeListResponse(
          recipes: cachedRecipes.map((recipe) => recipe.toEntity()).toList(),
          total: cachedRecipes.length,
          skip: 0,
          limit: cachedRecipes.length,
        );
      }

      rethrow;
    }
  }

  @override
  Future<Recipe> getRecipe(int id) async {
    final cachedRecipe = await _localDataSource.getRecipe(id);

    if (cachedRecipe != null) {
      return cachedRecipe.toEntity();
    }

    final recipe = await _remoteDataSource.getRecipe(id);

    return recipe.toEntity();
  }

  @override
  Future<RecipeListResponse> searchRecipes({required String query}) async {
    final response = await _remoteDataSource.searchRecipes(query: query);

    return response.toEntity();
  }

  @override
  Future<List<String>> getTags() {
    return _remoteDataSource.getTags();
  }

  @override
  Future<RecipeListResponse> getRecipesByTag({required String tag}) async {
    final response = await _remoteDataSource.getRecipesByTag(tag: tag);

    return response.toEntity();
  }
}
