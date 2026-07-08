import 'package:flutter/material.dart';

import '../../domain/entities/recipe.dart';
import 'recipe_card.dart';

class RecipeList extends StatelessWidget {
  final ScrollController controller;
  final List<Recipe> recipes;
  final bool isLoadingMore;

  const RecipeList({
    super.key,
    required this.controller,
    required this.recipes,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        if (index == recipes.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return RecipeCard(recipe: recipes[index]);
      },
    );
  }
}
