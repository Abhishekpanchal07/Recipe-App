import 'package:hive_ce/hive.dart';

import '../../domain/entities/recipe.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0)
class RecipeModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String> ingredients;

  @HiveField(3)
  final List<String> instructions;

  @HiveField(4)
  final int prepTimeMinutes;

  @HiveField(5)
  final int cookTimeMinutes;

  @HiveField(6)
  final int servings;

  @HiveField(7)
  final String difficulty;

  @HiveField(8)
  final String cuisine;

  @HiveField(9)
  final int caloriesPerServing;

  @HiveField(10)
  final List<String> tags;

  @HiveField(11)
  final int userId;

  @HiveField(12)
  final String image;

  @HiveField(13)
  final double rating;

  @HiveField(14)
  final int reviewCount;

  @HiveField(15)
  final List<String> mealType;

  const RecipeModel({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      ingredients: List<String>.from(json['ingredients'] ?? const []),
      instructions: List<String>.from(json['instructions'] ?? const []),
      prepTimeMinutes: json['prepTimeMinutes'] as int,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      servings: json['servings'] as int,
      difficulty: json['difficulty'] as String,
      cuisine: json['cuisine'] as String,
      caloriesPerServing: json['caloriesPerServing'] as int,
      tags: List<String>.from(json['tags'] ?? const []),
      userId: json['userId'] as int,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      mealType: List<String>.from(json['mealType'] ?? const []),
    );
  }

  factory RecipeModel.fromEntity(Recipe recipe) {
    return RecipeModel(
      id: recipe.id,
      name: recipe.name,
      ingredients: recipe.ingredients,
      instructions: recipe.instructions,
      prepTimeMinutes: recipe.prepTimeMinutes,
      cookTimeMinutes: recipe.cookTimeMinutes,
      servings: recipe.servings,
      difficulty: recipe.difficulty,
      cuisine: recipe.cuisine,
      caloriesPerServing: recipe.caloriesPerServing,
      tags: recipe.tags,
      userId: recipe.userId,
      image: recipe.image,
      rating: recipe.rating,
      reviewCount: recipe.reviewCount,
      mealType: recipe.mealType,
    );
  }

  Recipe toEntity() {
    return Recipe(
      id: id,
      name: name,
      ingredients: ingredients,
      instructions: instructions,
      prepTimeMinutes: prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes,
      servings: servings,
      difficulty: difficulty,
      cuisine: cuisine,
      caloriesPerServing: caloriesPerServing,
      tags: tags,
      userId: userId,
      image: image,
      rating: rating,
      reviewCount: reviewCount,
      mealType: mealType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'difficulty': difficulty,
      'cuisine': cuisine,
      'caloriesPerServing': caloriesPerServing,
      'tags': tags,
      'userId': userId,
      'image': image,
      'rating': rating,
      'reviewCount': reviewCount,
      'mealType': mealType,
    };
  }
}