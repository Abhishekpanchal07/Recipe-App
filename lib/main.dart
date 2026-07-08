import 'package:flutter/material.dart';

import 'package:recipe_app/app/app.dart';

import 'app/di/injection_container.dart';

import 'core/storage/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  await sl<HiveService>().init();

  runApp(const RecipeApp());
}
