import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail/bloc/recipe_detail_bloc.dart';
import 'detail/bloc/recipe_detail_state.dart';
import 'detail/widgets/ingredient_section.dart';
import 'detail/widgets/instruction_section.dart';
import 'detail/widgets/recipe_header.dart';
import 'detail/widgets/recipe_stats.dart';
import 'detail/widgets/recipe_tags.dart';

class RecipeDetailPage extends StatelessWidget {
  final int recipeId;

  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe')),
      body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError) {
            return Center(child: Text(state.errorMessage!));
          }

          if (!state.hasRecipe) {
            return const SizedBox();
          }

          final recipe = state.recipe!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeHeader(recipe: recipe),
                SizedBox(height: 20),

                RecipeStats(recipe: recipe),

                RecipeTags(recipe: recipe),
                IngredientSection(recipe: recipe),
                InstructionSection(recipe: recipe),
              ],
            ),
          );
        },
      ),
    );
  }
}
