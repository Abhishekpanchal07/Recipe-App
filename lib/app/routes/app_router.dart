import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/feature/recipe/presentation/detail/bloc/recipe_detail_bloc.dart';
import 'package:recipe_app/feature/recipe/presentation/detail/bloc/recipe_detail_event.dart';
import 'package:recipe_app/feature/recipe/presentation/recipe_detail_page.dart';
import '../di/injection_container.dart';
import '../../feature/auth/presentation/pages/login_page.dart';
import '../../feature/auth/presentation/pages/splash_page.dart';
import '../../feature/recipe/presentation/bloc/recipe_bloc.dart';
import '../../feature/recipe/presentation/bloc/recipe_event.dart';
import '../../feature/recipe/presentation/recipe_page.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(path: RouteNames.splash, builder: (_, _) => const SplashPage()),
      GoRoute(path: RouteNames.login, builder: (_, _) => const LoginPage()),
      GoRoute(
        path: RouteNames.recipes,
        builder: (_, _) => BlocProvider(
          create: (_) => sl<RecipeBloc>()..add(const LoadRecipes()),
          child: const RecipePage(),
        ),
      ),
      GoRoute(
        path: RouteNames.recipeDetail,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id'] ?? '0');

          return BlocProvider(
            create: (_) => sl<RecipeDetailBloc>()..add(LoadRecipeDetail(id)),
            child: RecipeDetailPage(recipeId: id),
          );
        },
      ),
    ],
  );
}
