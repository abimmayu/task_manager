import 'package:task_manager/core/error/failure.dart';

class AuthError extends Failure {
  AuthError({
    super.message,
  }) : super(
          title: "Authentication Failed!",
        );
}
