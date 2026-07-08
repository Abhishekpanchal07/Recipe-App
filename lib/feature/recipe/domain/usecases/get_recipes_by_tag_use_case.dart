import '../entities/recipe_list_response.dart';
import '../repositories/recipe_repository.dart';

class GetRecipesByTagUseCase {
  final RecipeRepository _repository;

  GetRecipesByTagUseCase(this._repository);

  Future<RecipeListResponse> call(String tag) {
    return _repository.getRecipesByTag(tag: tag);
  }
}