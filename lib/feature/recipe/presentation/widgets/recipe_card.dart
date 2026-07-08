import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/recipe.dart';
import 'recipe_badge.dart';
import 'recipe_image.dart';
import 'recipe_info_row.dart';
import 'recipe_tag_list.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalTime =
        recipe.prepTimeMinutes + recipe.cookTimeMinutes;

    return InkWell(
      onTap: () {
    context.push(
      '/recipes/${recipe.id}',
    );
  },
      borderRadius: BorderRadius.circular(20),
     
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecipeImage(
              heroTag: 'recipe_${recipe.id}',
              imageUrl: recipe.image,
              rating: recipe.rating,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          recipe.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      RecipeBadge(
                        difficulty: recipe.difficulty,
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    recipe.cuisine,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: Colors.grey,
                        ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: RecipeInfoRow(
                          icon: Icons.schedule,
                          value: '$totalTime min',
                        ),
                      ),
                      Expanded(
                        child: RecipeInfoRow(
                          icon: Icons.people_outline,
                          value:
                              '${recipe.servings} Servings',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  RecipeInfoRow(
                    icon:
                        Icons.local_fire_department_outlined,
                    value:
                        '${recipe.caloriesPerServing} kcal',
                  ),

                  const SizedBox(height: 16),

                  RecipeTagList(
                    tags: recipe.tags,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}