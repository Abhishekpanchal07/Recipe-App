import 'package:equatable/equatable.dart';

import 'recipe.dart';

class RecipeListResponse extends Equatable {
  final List<Recipe> recipes;
  final int total;
  final int skip;
  final int limit;

  const RecipeListResponse({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        recipes,
        total,
        skip,
        limit,
      ];
}