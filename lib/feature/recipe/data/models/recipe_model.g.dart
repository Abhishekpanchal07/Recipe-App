// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final typeId = 0;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      ingredients: (fields[2] as List).cast<String>(),
      instructions: (fields[3] as List).cast<String>(),
      prepTimeMinutes: (fields[4] as num).toInt(),
      cookTimeMinutes: (fields[5] as num).toInt(),
      servings: (fields[6] as num).toInt(),
      difficulty: fields[7] as String,
      cuisine: fields[8] as String,
      caloriesPerServing: (fields[9] as num).toInt(),
      tags: (fields[10] as List).cast<String>(),
      userId: (fields[11] as num).toInt(),
      image: fields[12] as String,
      rating: (fields[13] as num).toDouble(),
      reviewCount: (fields[14] as num).toInt(),
      mealType: (fields[15] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ingredients)
      ..writeByte(3)
      ..write(obj.instructions)
      ..writeByte(4)
      ..write(obj.prepTimeMinutes)
      ..writeByte(5)
      ..write(obj.cookTimeMinutes)
      ..writeByte(6)
      ..write(obj.servings)
      ..writeByte(7)
      ..write(obj.difficulty)
      ..writeByte(8)
      ..write(obj.cuisine)
      ..writeByte(9)
      ..write(obj.caloriesPerServing)
      ..writeByte(10)
      ..write(obj.tags)
      ..writeByte(11)
      ..write(obj.userId)
      ..writeByte(12)
      ..write(obj.image)
      ..writeByte(13)
      ..write(obj.rating)
      ..writeByte(14)
      ..write(obj.reviewCount)
      ..writeByte(15)
      ..write(obj.mealType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
