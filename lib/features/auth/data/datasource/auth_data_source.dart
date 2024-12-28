import 'package:task_manager/core/constant/url.dart';
import 'package:task_manager/core/service/dio/dio_service.dart';
import 'package:task_manager/features/auth/data/models/auth_request.dart';
import 'package:task_manager/features/auth/data/models/login_response.dart';
import 'package:task_manager/features/auth/data/models/register_response.dart';

abstract class AuthDataSource {
  Future<LoginResponse?> login(String email, String password);
  Future<RegisterResponse?> register(
    String email,
    String password,
  );
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<LoginResponse?> login(String email, String password) async {
    final request = AuthRequest(
      email: email,
      password: password,
    ).toJson();
    final result = await postIt(
      AppUrl.login,
      body: request,
    );
    return LoginResponse.fromJson(result.data);
  }

  @override
  Future<RegisterResponse?> register(
    String email,
    String password,
  ) async {
    final request = AuthRequest(
      email: email,
      password: password,
    ).toJson();
    final result = await postIt(
      AppUrl.register,
      body: request,
    );
    return RegisterResponse.fromJson(result.data);
  }
}
