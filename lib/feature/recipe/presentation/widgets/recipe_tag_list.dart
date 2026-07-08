import 'package:flutter/material.dart';

class RecipeTagList extends StatelessWidget {
  final List<String> tags;

  const RecipeTagList({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tag,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium,
              ),
            ),
          )
          .toList(),
    );
  }
}