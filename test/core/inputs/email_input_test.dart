import 'package:ella/core/inputs/email_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('email input test', () {

    test('empty email field', () {
      final email = EmailInput.pure();
      expect(email.error, EmailInputError.empty);
    });

    test('not email', () {
      final email = EmailInput.dirty('azim@kfdjlsfj');
      expect(email.error, EmailInputError.notEmail);
    });

    test('correct email', () {
      final email = EmailInput.dirty('azimdjan18@gmail.com');
      expect(email.error, null);
    });
  });
}