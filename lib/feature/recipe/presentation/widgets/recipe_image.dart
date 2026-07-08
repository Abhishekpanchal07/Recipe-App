import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final double rating;

  const RecipeImage({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (_, _) => Container(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
              errorWidget: (_, _, _) => Container(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 42,
                  ),
                ),
              ),
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(.55),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            /// Rating Badge
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.65),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}