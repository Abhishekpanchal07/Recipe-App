import '../entities/recipe_list_response.dart';
import '../repositories/recipe_repository.dart';

class SearchRecipesUseCase {
  final RecipeRepository _repository;

  SearchRecipesUseCase(this._repository);

  Future<RecipeListResponse> call(String query) {
    return _repository.searchRecipes(query: query);
  }
}