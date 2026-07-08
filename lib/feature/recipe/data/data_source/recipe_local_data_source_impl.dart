import '../../../../core/storage/hive_service.dart';
import '../models/recipe_model.dart';
import 'recipe_local_data_source.dart';

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final HiveService _hiveService;

  RecipeLocalDataSourceImpl({
    required this._hiveService,
  });

  @override
  Future<void> saveRecipes(List<RecipeModel> recipes) async {
    final box = _hiveService.recipeBox;

    final Map<int, RecipeModel> map = {
      for (final recipe in recipes) recipe.id: recipe,
    };

    await box.putAll(map);
  }

  @override
  Future<List<RecipeModel>> getRecipes() async {
    return _hiveService.recipeBox.values.toList();
  }

  @override
  Future<RecipeModel?> getRecipe(int id) async {
    return _hiveService.recipeBox.get(id);
  }

  @override
  Future<void> clearRecipes() async {
    await _hiveService.recipeBox.clear();
  }
}