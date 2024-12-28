import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/core/error/auth_error.dart';
import 'package:task_manager/core/service/local_storage/secure_storage.dart';
import 'package:task_manager/features/auth/data/models/login_response.dart';
import 'package:task_manager/features/auth/data/models/register_response.dart';
import 'package:task_manager/features/auth/domain/usecases/auth_usecases.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:dartz/dartz.dart';

class MockAuthUsecase extends Mock implements AuthUsecase {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late AuthBloc authBloc;
  late MockAuthUsecase mockAuthUsecase;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockAuthUsecase = MockAuthUsecase();
    mockSecureStorage = MockSecureStorage();

    // Inject mock SecureStorage
    authBloc = AuthBloc(mockAuthUsecase)..storage = mockSecureStorage;

    // Register default behavior for mocks
    registerFallbackValue(AuthLogin(email: '', password: ''));
  });

  group('AuthBloc', () {
    const mockEmail = 'eve.holt@reqres.in';
    const mockPassword = 'password';
    const mockToken = 'mock_token';
    const mockId = 1;

    final mockLoginResponse = LoginResponse(token: mockToken);
    final mockRegisterResponse = RegisterResponse(id: mockId, token: mockToken);

    test('initial state is AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthDone] when login succeeds',
      build: () {
        when(() => mockAuthUsecase.executeLogin(mockEmail, mockPassword))
            .thenAnswer((_) async => Right(mockLoginResponse));

        when(() => mockSecureStorage.write('token', mockToken))
            .thenAnswer((_) async => Future.value());
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthLogin(email: mockEmail, password: mockPassword)),
      expect: () => [
        AuthLoading(),
        AuthDone(token: mockToken),
      ],
      verify: (_) {
        verify(() => mockAuthUsecase.executeLogin(mockEmail, mockPassword))
            .called(1);
        verify(() => mockSecureStorage.write('token', mockToken)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailed] when login fails',
      build: () {
        when(() => mockAuthUsecase.executeLogin(mockEmail, mockPassword))
            .thenAnswer((_) async => Left(AuthError(message: 'Login failed')));

        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthLogin(email: mockEmail, password: mockPassword)),
      expect: () => [
        AuthLoading(),
        AuthFailed('Login failed'),
      ],
      verify: (_) {
        verify(() => mockAuthUsecase.executeLogin(mockEmail, mockPassword))
            .called(1);
        verifyNever(() => mockSecureStorage.write(any(), any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthDone] when register succeeds',
      build: () {
        when(() => mockAuthUsecase.executeRegister(mockEmail, mockPassword))
            .thenAnswer((_) async => Right(mockRegisterResponse));

        when(() => mockSecureStorage.write('token', mockToken))
            .thenAnswer((_) async => Future.value());
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthRegister(email: mockEmail, password: mockPassword)),
      expect: () => [
        AuthLoading(),
        AuthDone(token: mockToken, id: mockId),
      ],
      verify: (_) {
        verify(() => mockAuthUsecase.executeRegister(mockEmail, mockPassword))
            .called(1);
        verify(() => mockSecureStorage.write('token', mockToken)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailed] when register fails',
      build: () {
        when(() => mockAuthUsecase.executeRegister(mockEmail, mockPassword))
            .thenAnswer(
                (_) async => Left(AuthError(message: 'Registration failed')));

        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthRegister(email: mockEmail, password: mockPassword)),
      expect: () => [
        AuthLoading(),
        AuthFailed('Registration failed'),
      ],
      verify: (_) {
        verify(() => mockAuthUsecase.executeRegister(mockEmail, mockPassword))
            .called(1);
        verifyNever(() => mockSecureStorage.write(any(), any()));
      },
    );
  });
}
