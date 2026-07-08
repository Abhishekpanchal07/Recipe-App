import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/app/di/injection_container.dart';
import 'package:recipe_app/app/routes/app_router.dart';
import 'package:recipe_app/core/connectivity/connectivity_cubit.dart';
import 'package:recipe_app/core/constants/app_constants.dart';
import 'package:recipe_app/core/theme/app_theme.dart';
import 'package:recipe_app/core/theme/theme_cubit.dart';
import 'package:recipe_app/core/theme/theme_state.dart';
import 'package:recipe_app/feature/auth/presentation/bloc/auth_bloc.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
        BlocProvider(
          create: (_) {
            debugPrint("🔥 Creating ConnectivityCubit");
            return sl<ConnectivityCubit>();
          },
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
