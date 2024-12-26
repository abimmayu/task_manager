import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/features/auth/data/models/login_response.dart';
import 'package:task_manager/features/auth/data/models/register_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(
    String email,
    String password,
  );
  Future<Either<Failure, RegisterResponse>> register(
    String email,
    String password,
  );
}
