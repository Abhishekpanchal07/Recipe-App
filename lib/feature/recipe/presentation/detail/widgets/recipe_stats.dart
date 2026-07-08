import 'package:flutter/material.dart';

import '../../../domain/entities/recipe.dart';

class RecipeStats extends StatelessWidget {
  final Recipe recipe;

  const RecipeStats({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          SizedBox(
            width: (width - 56) / 2,
            child: _StatCard(
              icon: Icons.schedule,
              title: "Time",
              value:
                  "${recipe.prepTimeMinutes + recipe.cookTimeMinutes} min",
            ),
          ),
          SizedBox(
            width: (width - 56) / 2,
            child: _StatCard(
              icon: Icons.people,
              title: "Servings",
              value: "${recipe.servings}",
            ),
          ),
          SizedBox(
            width: (width - 56) / 2,
            child: _StatCard(
              icon: Icons.local_fire_department,
              title: "Calories",
              value: "${recipe.caloriesPerServing} kcal",
            ),
          ),
          SizedBox(
            width: (width - 56) / 2,
            child: _StatCard(
              icon: Icons.restaurant,
              title: "Cuisine",
              value: recipe.cuisine,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.primary.withOpacity(.12),
              child: Icon(
                icon,
                color: colorScheme.primary,
                size: 24,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}