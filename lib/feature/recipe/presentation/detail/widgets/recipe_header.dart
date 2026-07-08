import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/recipe.dart';

class RecipeHeader extends StatelessWidget {
  final Recipe recipe;

  const RecipeHeader({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'recipe-${recipe.id}',
          child: CachedNetworkImage(
            imageUrl: recipe.image,
            width: double.infinity,
            height: 280,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              height: 280,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            errorWidget: (_, __, ___) => Container(
              height: 280,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, size: 60),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Text(
            recipe.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            recipe.cuisine,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),

              const SizedBox(width: 6),

              Text(
                recipe.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),

              const SizedBox(width: 6),

              Text(
                '(${recipe.reviewCount} reviews)',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const Spacer(),

              Chip(
                avatar: Icon(
                  recipe.difficulty == 'Easy'
                      ? Icons.sentiment_satisfied_alt
                      : recipe.difficulty == 'Medium'
                          ? Icons.sentiment_neutral
                          : Icons.local_fire_department,
                  size: 18,
                ),
                label: Text(recipe.difficulty),
              ),
            ],
          ),
        ),
      ],
    );
  }
}