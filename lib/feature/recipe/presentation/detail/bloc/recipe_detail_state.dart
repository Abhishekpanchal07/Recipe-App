import 'package:equatable/equatable.dart';

import '../../../domain/entities/recipe.dart';

class RecipeDetailState extends Equatable {
  final Recipe? recipe;

  final bool isLoading;

  final String? errorMessage;

  const RecipeDetailState({
    this.recipe,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get hasRecipe => recipe != null;

  bool get hasError => errorMessage != null;

  RecipeDetailState copyWith({
    Recipe? recipe,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RecipeDetailState(
      recipe: recipe ?? this.recipe,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        recipe,
        isLoading,
        errorMessage,
      ];
}