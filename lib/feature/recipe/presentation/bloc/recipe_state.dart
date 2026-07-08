import 'package:equatable/equatable.dart';

import '../../domain/entities/recipe.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;

  /// Initial loading (Show Shimmer)
  final bool isLoading;

  /// Pull to Refresh
  final bool isRefreshing;

  /// Bottom Pagination Loader
  final bool isLoadingMore;

  /// Offline Cache
  final bool isOffline;

  /// No more pages
  final bool hasReachedMax;

  final int total;
  final int skip;
  final int limit;

  /// Error Message
  final String? errorMessage;
  final List<Recipe> originalRecipes;
  final bool isSearching;

  const RecipeState({
    this.recipes = const [],
    this.originalRecipes = const [],
    this.isSearching = false,
    this.isLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.isOffline = false,
    this.hasReachedMax = false,
    this.total = 0,
    this.skip = 0,
    this.limit = 30,
    this.errorMessage,
  });

  bool get hasRecipes => recipes.isNotEmpty;

  bool get hasError => errorMessage != null;

  bool get isEmpty => !isLoading && recipes.isEmpty && errorMessage == null;
  bool get hasSearch => isSearching;

  RecipeState copyWith({
    List<Recipe>? recipes,
    bool? isLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    bool? isOffline,
    bool? hasReachedMax,
    int? total,
    int? skip,
    int? limit,
    String? errorMessage,
    bool clearError = false,
    List<Recipe>? originalRecipes,
    bool? isSearching,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isOffline: isOffline ?? this.isOffline,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      originalRecipes: originalRecipes ?? this.originalRecipes,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
    recipes,
    originalRecipes,
    isSearching,
    isLoading,
    isRefreshing,
    isLoadingMore,
    isOffline,
    hasReachedMax,
    total,
    skip,
    limit,
    errorMessage,
  ];
}
