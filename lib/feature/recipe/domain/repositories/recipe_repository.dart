import '../entities/recipe.dart';
import '../entities/recipe_list_response.dart';

abstract interface class RecipeRepository {
  Future<RecipeListResponse> getRecipes({
    required int skip,
    required int limit,
    bool forceRefresh = false,
  });

  Future<Recipe> getRecipe(int id);

  Future<RecipeListResponse> searchRecipes({
    required String query,
  });

  Future<List<String>> getTags();

  Future<RecipeListResponse> getRecipesByTag({
    required String tag,
  });
}