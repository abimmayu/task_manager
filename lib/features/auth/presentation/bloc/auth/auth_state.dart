part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthDone extends AuthState {
  final String token;
  final int? id;
  AuthDone({
    required this.token,
    this.id,
  });

  @override
  List<Object> get props {
    if (id != null) {
      return [
        token,
        id!,
      ];
    } else {
      return [
        token,
      ];
    }
  }
}

class AuthFailed extends AuthState {
  final String error;
  AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}
