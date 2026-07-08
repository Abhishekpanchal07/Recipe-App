import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_recipe_use_case.dart';

import 'recipe_detail_event.dart';
import 'recipe_detail_state.dart';

class RecipeDetailBloc
    extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeUseCase _getRecipeUseCase;

  RecipeDetailBloc({
    required this._getRecipeUseCase,
  })  : super(const RecipeDetailState()) {
    on<LoadRecipeDetail>(_onLoadRecipeDetail);
  }

  Future<void> _onLoadRecipeDetail(
    LoadRecipeDetail event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
      ),
    );

    try {
      final recipe = await _getRecipeUseCase(
        event.id,
      );

      emit(
        state.copyWith(
          recipe: recipe,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}