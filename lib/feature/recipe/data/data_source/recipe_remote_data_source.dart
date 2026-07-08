import '../models/recipe_list_response_model.dart';
import '../models/recipe_model.dart';

abstract interface class RecipeRemoteDataSource {
  Future<RecipeListResponseModel> getRecipes({
    required int skip,
    required int limit,
  });

  Future<RecipeModel> getRecipe(int id);

  Future<RecipeListResponseModel> searchRecipes({
    required String query,
  });

  Future<List<String>> getTags();

  Future<RecipeListResponseModel> getRecipesByTag({
    required String tag,
  });
}