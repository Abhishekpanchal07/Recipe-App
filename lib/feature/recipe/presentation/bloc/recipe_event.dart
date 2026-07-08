import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecipes extends RecipeEvent {
  const LoadRecipes();
}

class RefreshRecipes extends RecipeEvent {
  const RefreshRecipes();
}

class LoadMoreRecipes extends RecipeEvent {
  const LoadMoreRecipes();
}

class SearchRecipes extends RecipeEvent {
  final String query;

  const SearchRecipes(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadRecipesByTag extends RecipeEvent {
  final String tag;

  const LoadRecipesByTag(this.tag);

  @override
  List<Object?> get props => [tag];
}
/* class LoadRecipeDetail extends RecipeEvent {
  final int id;

  const LoadRecipeDetail(this.id);

  @override
  List<Object?> get props => [id];
}*/
class ClearSearch extends RecipeEvent {
  const ClearSearch();

  @override
  List<Object?> get props => [];
} 