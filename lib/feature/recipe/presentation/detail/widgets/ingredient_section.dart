import 'package:flutter/material.dart';

import '../../../domain/entities/recipe.dart';

class IngredientSection extends StatelessWidget {
  final Recipe recipe;

  const IngredientSection({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 16),

          ...recipe.ingredients.map(
            (ingredient) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      Colors.green.withOpacity(.12),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                title: Text(
                  ingredient,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}