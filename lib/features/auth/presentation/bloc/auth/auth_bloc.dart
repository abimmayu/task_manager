import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/service/local_storage/secure_storage.dart';
import 'package:task_manager/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;

  final SecureStorage storage = SecureStorage();

  AuthBloc(
    this.authUsecase,
  ) : super(
          AuthInitial(),
        ) {
    on<AuthLogin>(
      (event, emit) => login(event, emit),
    );
    on<AuthRegister>(
      (event, emit) => register(event, emit),
    );
  }

  Future<void> login(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      AuthLoading(),
    );

    final response = await authUsecase.executeLogin(
      event.email,
      event.password,
    );

    response.fold(
      (l) => emit(
        AuthFailed(l.message!),
      ),
      (r) {
        storage.write("token", r.token);
        emit(
          AuthDone(
            token: r.token,
          ),
        );
      },
    );
  }

  Future<void> register(AuthRegister event, Emitter<AuthState> emit) async {
    emit(
      AuthLoading(),
    );

    final response = await authUsecase.executeRegister(
      event.email,
      event.password,
    );

    response.fold(
      (l) => emit(
        AuthFailed(l.message!),
      ),
      (r) {
        storage.write("token", r.token);
        emit(
          AuthDone(
            token: r.token,
            id: r.id,
          ),
        );
      },
    );
  }
}
