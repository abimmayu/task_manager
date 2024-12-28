import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/utils/login_validator.dart';

void main() {
  group('LoginValidator', () {
    test('validateEmail returns error for empty email', () {
      expect(LoginValidator.validateEmail(''), 'Email cannot be empty');
    });

    test('validateEmail returns error for invalid email', () {
      expect(
          LoginValidator.validateEmail('invalidemail'), 'Enter a valid email');
    });

    test('validateEmail returns null for valid email', () {
      expect(LoginValidator.validateEmail('user@example.com'), null);
    });

    test('validatePassword returns error for empty password', () {
      expect(LoginValidator.validatePassword(''), 'Password cannot be empty');
    });

    test('validatePassword returns error for short password', () {
      expect(LoginValidator.validatePassword('123'),
          'Password must be at least 6 characters');
    });

    test('validatePassword returns null for valid password', () {
      expect(LoginValidator.validatePassword('password123'), null);
    });
  });
}
