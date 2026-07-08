import 'package:equatable/equatable.dart';

abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecipeDetail extends RecipeDetailEvent {
  final int id;

  const LoadRecipeDetail(this.id);

  @override
  List<Object?> get props => [id];
}