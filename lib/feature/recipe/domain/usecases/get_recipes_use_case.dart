import '../entities/recipe_list_response.dart';
import '../repositories/recipe_repository.dart';

class GetRecipesUseCase {
  final RecipeRepository _repository;

  GetRecipesUseCase(this._repository);

  Future<RecipeListResponse> call({
    required int skip,
    required int limit,
    bool forceRefresh = false,
  }) {
    return _repository.getRecipes(
      skip: skip,
      limit: limit,
      forceRefresh: forceRefresh,
    );
  }
}