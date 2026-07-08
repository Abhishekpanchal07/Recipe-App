import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeUseCase {
  final RecipeRepository _repository;

  GetRecipeUseCase(this._repository);

  Future<Recipe> call(int id) {
    return _repository.getRecipe(id);
  }
}