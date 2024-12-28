import 'package:get_it/get_it.dart';
import 'package:task_manager/features/auth/data/datasource/auth_data_source.dart';
import 'package:task_manager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';
import 'package:task_manager/features/auth/domain/usecases/auth_usecases.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/auth/presentation/bloc/splash/splash_bloc.dart';
import 'package:task_manager/features/task/data/datasource/task_datasource.dart';
import 'package:task_manager/features/task/data/repository/task_repository_impl.dart';
import 'package:task_manager/features/task/domain/repository/task_repository.dart';
import 'package:task_manager/features/task/domain/usecases/task_usecase.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';

final GetIt sl = GetIt.instance;

init() async {
  await _auth();
  await _tasks();
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
