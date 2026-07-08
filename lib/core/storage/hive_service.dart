import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../feature/recipe/data/models/recipe_model.dart';
import '../constants/hive_boxes.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(RecipeModelAdapter());

    await Future.wait([
      Hive.openBox<RecipeModel>(HiveBoxes.recipes),
    ]);
  }

  Box<RecipeModel> get recipeBox =>
      Hive.box<RecipeModel>(HiveBoxes.recipes);

  Future<void> clearAll() async {
    await Hive.deleteFromDisk();
  }

  Future<void> close() async {
    await Hive.close();
  }
}