import '../repositories/recipe_repository.dart';

class GetTagsUseCase {
  final RecipeRepository _repository;

  GetTagsUseCase(this._repository);

  Future<List<String>> call() {
    return _repository.getTags();
  }
}