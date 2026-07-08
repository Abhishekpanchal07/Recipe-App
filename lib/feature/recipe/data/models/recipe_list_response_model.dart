import '../../domain/entities/recipe_list_response.dart';
import 'recipe_model.dart';

class RecipeListResponseModel {
  final List<RecipeModel> recipes;
  final int total;
  final int skip;
  final int limit;

  const RecipeListResponseModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory RecipeListResponseModel.fromJson(Map<String, dynamic> json) {
    return RecipeListResponseModel(
      recipes: (json['recipes'] as List)
          .map(
            (recipe) => RecipeModel.fromJson(
              recipe as Map<String, dynamic>,
            ),
          )
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }

  RecipeListResponse toEntity() {
    return RecipeListResponse(
      recipes: recipes
          .map((recipe) => recipe.toEntity())
          .toList(),
      total: total,
      skip: skip,
      limit: limit,
    );
  }
}