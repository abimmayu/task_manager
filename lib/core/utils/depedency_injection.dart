import 'package:get_it/get_it.dart';
import 'package:task_manager/features/auth/data/datasource/auth_data_source.dart';
import 'package:task_manager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';
import 'package:task_manager/features/auth/domain/usecases/auth_usecases.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';

final GetIt sl = GetIt.instance;

init() async {
  await _auth();
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
}
