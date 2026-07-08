import '../models/recipe_model.dart';

abstract interface class RecipeLocalDataSource {
  Future<void> saveRecipes(List<RecipeModel> recipes);

  Future<List<RecipeModel>> getRecipes();

  Future<RecipeModel?> getRecipe(int id);

  Future<void> clearRecipes();
}