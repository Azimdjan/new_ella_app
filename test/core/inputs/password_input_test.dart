import 'package:ella/core/inputs/password_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('password input test', () {
    test('empty password field', () {
      final password = PasswordInput.pure();
      expect(password.error, PasswordInputError.empty);
    });

    test('short password', () {
      final password = PasswordInput.dirty('Lifjdk');
      expect(password.error, PasswordInputError.short);
    });

    test('long password', () {
      final password = PasswordInput.dirty('Lifdjsfnakdnfjksdanfkjafjkdnsfafdsf');
      expect(password.error, PasswordInputError.long);
    });

    test('correct name', () {
      final name = PasswordInput.dirty('Ldfjdffee');
      expect(name.error, null);
    });
  });
}