import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/auth/data/datasource/auth_data_source.dart';
import 'package:task_manager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';
import 'package:task_manager/features/auth/domain/usecases/auth_usecases.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/auth/presentation/bloc/splash/splash_bloc.dart';
import 'package:task_manager/features/task/data/datasource/task_datasource.dart';
import 'package:task_manager/features/task/data/datasource/theme_datasource.dart';
import 'package:task_manager/features/task/data/repository/task_repository_impl.dart';
import 'package:task_manager/features/task/data/repository/theme_repository_imp.dart';
import 'package:task_manager/features/task/domain/repository/task_repository.dart';
import 'package:task_manager/features/task/domain/repository/theme_repository.dart';
import 'package:task_manager/features/task/domain/usecases/task_usecase.dart';
import 'package:task_manager/features/task/domain/usecases/theme_usecase.dart';
import 'package:task_manager/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/theme/theme_bloc.dart';

final GetIt sl = GetIt.instance;

init() async {
  await _localStorage();
  await _auth();
  await _tasks();
  await _theme();
}

Future<void> _localStorage() async {
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

Future<void> _auth() async {
  // Datasources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  // Usecases
  sl.registerLazySingleton<AuthUsecase>(
    () => AuthUsecase(
      sl(),
    ),
  );

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      sl(),
    ),
  );
  sl.registerFactory(
    () => SplashBloc(),
  );
}

Future<void> _tasks() async {
  // Datasource
  sl.registerLazySingleton<TaskDatasource>(
    () => TaskDatasourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      sl(),
    ),
  );

  // Usecase
  sl.registerLazySingleton<TaskUsecase>(
    () => TaskUsecase(
      sl(),
    ),
  );

  // Bloc
  sl.registerFactory(
    () => TaskBloc(
      sl(),
    ),
  );
}

Future<void> _theme() async {
  // Datasource
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(
      sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(
      sl(),
    ),
  );

  // Usecase
  sl.registerLazySingleton<ToggleThemeUseCase>(
    () => ToggleThemeUseCase(
      sl(),
    ),
  );

  // Bloc
  sl.registerFactory(
    () => ThemeCubit(
      sl(),
    ),
  );
}
