import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_manager/core/error/auth_error.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/features/auth/data/datasource/auth_data_source.dart';
import 'package:task_manager/features/auth/data/models/login_response.dart';
import 'package:task_manager/features/auth/data/models/register_response.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource = AuthDataSourceImpl();
  @override
  Future<Either<Failure, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await authDataSource.login(email, password);
      return Right(
        response!,
      );
    } on DioException catch (e) {
      return Left(
        AuthError(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        AuthError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(
    String email,
    String password,
  ) async {
    try {
      final response = await authDataSource.register(email, password);
      return Right(
        response!,
      );
    } on DioException catch (e) {
      return Left(
        AuthError(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        AuthError(message: e.toString()),
      );
    }
  }
}
