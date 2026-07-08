import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/app_exception_mapper.dart';
import '../../domain/usecases/get_recipes_by_tag_use_case.dart';
import '../../domain/usecases/get_recipes_use_case.dart';
import '../../domain/usecases/search_recipes_use_case.dart';

import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipesUseCase _getRecipesUseCase;
  //final GetRecipeUseCase _getRecipeUseCase;
  final SearchRecipesUseCase _searchRecipesUseCase;
  final GetRecipesByTagUseCase _getRecipesByTagUseCase;

  RecipeBloc({
    required this._getRecipesUseCase,
    //required this._getRecipeUseCase,
    required this._searchRecipesUseCase,
    required this._getRecipesByTagUseCase,
  }) : super(const RecipeState()) {
    on<LoadRecipes>(_onLoadRecipes);
    on<RefreshRecipes>(_onRefreshRecipes);
    on<LoadMoreRecipes>(_onLoadMoreRecipes);
    on<SearchRecipes>(_onSearchRecipes);
    on<LoadRecipesByTag>(_onLoadRecipesByTag);
   // on<LoadRecipeDetail>(_onLoadRecipeDetail);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onLoadRecipes(
    LoadRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final response = await _getRecipesUseCase(skip: 0, limit: state.limit);
      debugPrint('Response Total: ${response.total}');
      debugPrint('Response Length: ${response.recipes.length}');
      emit(
        state.copyWith(
          recipes: response.recipes,
          originalRecipes: response.recipes,
          total: response.total,
          skip: response.recipes.length,
          hasReachedMax: response.recipes.length >= response.total,
          isLoading: false,
          isOffline: false,
        ),
      );
    } catch (e) {
      _emitError(emit, error: e, isLoading: false);
    }
  }

  Future<void> _onRefreshRecipes(
    RefreshRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, clearError: true));

    try {
      final response = await _getRecipesUseCase(
        skip: 0,
        limit: state.limit,
        forceRefresh: true,
      );

      emit(
        state.copyWith(
          recipes: response.recipes,
          total: response.total,
          skip: response.recipes.length,
          isRefreshing: false,
          hasReachedMax: response.recipes.length >= response.total,
        ),
      );
    } catch (e) {
      _emitError(emit, error: e, isRefreshing: false);
    }
  }

  Future<void> _onLoadMoreRecipes(
    LoadMoreRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    debugPrint('LoadMoreRecipes Event Fired');
    debugPrint('isLoading: ${state.isLoading}');
    debugPrint('isLoadingMore: ${state.isLoadingMore}');
    debugPrint('hasReachedMax: ${state.hasReachedMax}');
    debugPrint('skip: ${state.skip}');
    debugPrint('limit: ${state.limit}');
    debugPrint('recipes: ${state.recipes.length}');
    if (state.isLoading || state.isLoadingMore || state.hasReachedMax) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final response = await _getRecipesUseCase(
        skip: state.skip,
        limit: state.limit,
      );

      final existingIds = state.recipes.map((recipe) => recipe.id).toSet();

      final newRecipes = response.recipes
          .where((recipe) => !existingIds.contains(recipe.id))
          .toList();

      final recipes = [...state.recipes, ...newRecipes];

      emit(
        state.copyWith(
          recipes: recipes,
          originalRecipes: recipes,
          skip: recipes.length,
          total: response.total,
          isLoadingMore: false,
          hasReachedMax:
              response.recipes.isEmpty || recipes.length >= response.total,
        ),
      );
    } catch (e) {
      _emitError(emit, error: e, isLoadingMore: false);
    }
  }

  Future<void> _onSearchRecipes(
    SearchRecipes event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final response = await _searchRecipesUseCase(event.query);

      emit(
        state.copyWith(
          recipes: response.recipes,
          isSearching: true,
          total: response.total,
          skip: response.recipes.length,
          isLoading: false,
          hasReachedMax: true,
          clearError: true,
        ),
      );
    } catch (e) {
      _emitError(emit, error: e, isLoading: false);
    }
  }

  Future<void> _onLoadRecipesByTag(
    LoadRecipesByTag event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final response = await _getRecipesByTagUseCase(event.tag);

      emit(
        state.copyWith(
          recipes: response.recipes,
          total: response.total,
          skip: response.recipes.length,
          isLoading: false,
          hasReachedMax: true,
        ),
      );
    } catch (e) {
      _emitError(emit, error: e, isLoading: false);
    }
  }

 /*  Future<void> _onLoadRecipeDetail(
    LoadRecipeDetail event,
    Emitter<RecipeState> emit,
  ) async {
    await _getRecipeUseCase(event.id);
  } */

  void _emitError(
    Emitter<RecipeState> emit, {
    bool isLoading = false,
    bool isRefreshing = false,
    bool isLoadingMore = false,
    required Object error,
  }) {
    emit(
      state.copyWith(
        isLoading: isLoading,
        isRefreshing: isRefreshing,
        isLoadingMore: isLoadingMore,
        errorMessage: AppExceptionMapper.map(error),
      ),
    );
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<RecipeState> emit,
  ) async {
    emit(
      state.copyWith(
        recipes: state.originalRecipes,
        isSearching: false,
        clearError: true,
        hasReachedMax: state.originalRecipes.length >= state.total,
        skip: state.originalRecipes.length,
      ),
    );
  }
}
