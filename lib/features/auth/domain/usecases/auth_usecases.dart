import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/features/auth/data/models/login_response.dart';
import 'package:task_manager/features/auth/data/models/register_response.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repository;

  AuthUsecase(this.repository);

  Future<Either<Failure, LoginResponse>> executeLogin(
    String email,
    String password,
  ) {
    return repository.login(email, password);
  }

  Future<Either<Failure, RegisterResponse>> executeRegister(
    String email,
    String password,
  ) {
    return repository.register(email, password);
  }
}
