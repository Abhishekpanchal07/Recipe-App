import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/core/connectivity/connectivity_cubit.dart';
import 'package:recipe_app/core/connectivity/connectivity_service.dart';
import 'package:recipe_app/core/network/api_client.dart';
import 'package:recipe_app/core/network/dio_client.dart';
import 'package:recipe_app/core/network/interceptors/auth_interceptor.dart';
import 'package:recipe_app/core/network/interceptors/logging_interceptor.dart';
import 'package:recipe_app/core/storage/app_preferences.dart';
import 'package:recipe_app/core/storage/hive_service.dart';
import 'package:recipe_app/core/theme/theme_cubit.dart';
import 'package:recipe_app/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:recipe_app/feature/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:recipe_app/feature/auth/domain/repositories/auth_repository_impl.dart';
import 'package:recipe_app/feature/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:recipe_app/feature/auth/domain/usecases/is_logged_in_use_case.dart';
import 'package:recipe_app/feature/auth/domain/usecases/login_use_case.dart';
import 'package:recipe_app/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:recipe_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:recipe_app/feature/recipe/data/data_source/recipe_local_data_source.dart';
import 'package:recipe_app/feature/recipe/data/data_source/recipe_local_data_source_impl.dart';
import 'package:recipe_app/feature/recipe/data/data_source/recipe_remote_data_source.dart';
import 'package:recipe_app/feature/recipe/data/data_source/recipe_remote_data_source_impl.dart';
import 'package:recipe_app/feature/recipe/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_app/feature/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_app/feature/recipe/domain/usecases/get_recipe_use_case.dart';
import 'package:recipe_app/feature/recipe/domain/usecases/get_recipes_by_tag_use_case.dart';
import 'package:recipe_app/feature/recipe/domain/usecases/get_recipes_use_case.dart';
import 'package:recipe_app/feature/recipe/domain/usecases/get_tags_use_case.dart';
import 'package:recipe_app/feature/recipe/domain/usecases/search_recipes_use_case.dart';
import 'package:recipe_app/feature/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_app/feature/recipe/presentation/detail/bloc/recipe_detail_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/interceptors/refresh_token_interceptor.dart';
import '../../core/services/logger_service.dart';
import '../../core/storage/secure_storage_service.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final preferences = await SharedPreferences.getInstance();

  /// External
  sl.registerLazySingleton<SharedPreferences>(() => preferences);

  sl.registerLazySingleton<AppPreferences>(
    () => AppPreferences(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(preferences: sl<AppPreferences>()),
  );
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<Logger>(() => LoggerService.instance);

  /// Services
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(sl()),
  );
  sl.registerLazySingleton<LoggingInterceptor>(
    () => LoggingInterceptor(logger: sl<Logger>()),
  );
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(secureStorageService: sl<SecureStorageService>()),
  );
  sl.registerLazySingleton<DioClient>(
    () => DioClient(
      loggingInterceptor: sl<LoggingInterceptor>(),
      authInterceptor: sl<AuthInterceptor>(),
    ),
  );

  sl.registerLazySingleton<Dio>(
    () => sl<DioClient>().dio,
    instanceName: 'mainDio',
  );

  sl.registerLazySingleton<Dio>(
    () => sl<DioClient>().tokenRefreshDio,
    instanceName: 'tokenRefreshDio',
  );

  sl.registerLazySingleton<RefreshTokenInterceptor>(
    () => RefreshTokenInterceptor(
      mainDio: sl<Dio>(instanceName: 'mainDio'),
      tokenRefreshDio: sl<Dio>(instanceName: 'tokenRefreshDio'),
      secureStorageService: sl<SecureStorageService>(),
      logger: sl<Logger>(),
    ),
  );

  sl<Dio>(
    instanceName: 'mainDio',
  ).interceptors.add(sl<RefreshTokenInterceptor>());
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl<Dio>(instanceName: 'mainDio')),
  );

  sl.registerLazySingleton<Connectivity>(
  () => Connectivity(),
);

sl.registerLazySingleton<ConnectivityService>(
  () => ConnectivityService(
    sl<Connectivity>(),
  ),
);

sl.registerLazySingleton<ConnectivityCubit>(
  () => ConnectivityCubit(
    sl<ConnectivityService>(),
  ),
);

  sl.registerLazySingleton<ConnectivityCubit>(
    () => ConnectivityCubit(sl<ConnectivityService>()),
  );
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      secureStorageService: sl<SecureStorageService>(),
    ),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<IsLoggedInUseCase>(
    () => IsLoggedInUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      isLoggedInUseCase: sl<IsLoggedInUseCase>(),
    ),
  );
  sl.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(hiveService: sl<HiveService>()),
  );
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      remoteDataSource: sl<RecipeRemoteDataSource>(),
      localDataSource: sl<RecipeLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton(() => GetRecipesUseCase(sl<RecipeRepository>()));

  sl.registerLazySingleton(() => GetRecipeUseCase(sl<RecipeRepository>()));

  sl.registerLazySingleton(() => SearchRecipesUseCase(sl<RecipeRepository>()));

  sl.registerLazySingleton(() => GetTagsUseCase(sl<RecipeRepository>()));

  sl.registerLazySingleton(
    () => GetRecipesByTagUseCase(sl<RecipeRepository>()),
  );
  sl.registerFactory(
    () => RecipeBloc(
      getRecipesUseCase: sl<GetRecipesUseCase>(),
      // getRecipeUseCase: sl<GetRecipeUseCase>(),
      searchRecipesUseCase: sl<SearchRecipesUseCase>(),
      getRecipesByTagUseCase: sl<GetRecipesByTagUseCase>(),
    ),
  );
  sl.registerFactory(
    () => RecipeDetailBloc(getRecipeUseCase: sl<GetRecipeUseCase>()),
  );
}
