import 'package:flutter/material.dart';

class RecipeBadge extends StatelessWidget {
  final String difficulty;

  const RecipeBadge({
    super.key,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    final (backgroundColor, textColor) = _getColors();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        difficulty,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  (Color, Color) _getColors() {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return (
          Colors.green.shade100,
          Colors.green.shade800,
        );

      case 'medium':
        return (
          Colors.orange.shade100,
          Colors.orange.shade800,
        );

      case 'hard':
        return (
          Colors.red.shade100,
          Colors.red.shade800,
        );

      default:
        return (
          Colors.grey.shade200,
          Colors.grey.shade800,
        );
    }
  }
}