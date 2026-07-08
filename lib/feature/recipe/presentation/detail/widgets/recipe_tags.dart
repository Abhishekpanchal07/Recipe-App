import 'package:flutter/material.dart';

import '../../../domain/entities/recipe.dart';

class RecipeTags extends StatelessWidget {
  final Recipe recipe;

  const RecipeTags({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    if (recipe.tags.isEmpty && recipe.mealType.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tags',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...recipe.tags.map(
                (tag) => Chip(
                  avatar: const Icon(
                    Icons.local_offer_rounded,
                    size: 18,
                  ),
                  label: Text(tag),
                ),
              ),

              ...recipe.mealType.map(
                (meal) => Chip(
                  backgroundColor: Colors.orange.withOpacity(.15),
                  avatar: const Icon(
                    Icons.restaurant_menu_rounded,
                    size: 18,
                    color: Colors.orange,
                  ),
                  label: Text(meal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}