import 'package:ella/core/forms/login_form.dart';
import 'package:ella/core/inputs/email_input.dart';
import 'package:ella/core/inputs/password_input.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  late EmailInput emailInput;
  late PasswordInput passwordInput;
  late LoginForm loginForm;
  setUp(() {
    emailInput = EmailInput.pure();
    passwordInput = PasswordInput.pure();
    loginForm = LoginForm(
      emailInput: emailInput,
      passwordInput: passwordInput,
    );
  });

  group('login form test', () {
    test('empty login form', () {
      expect(loginForm.status, FormzStatus.pure);
    });

    test('incorrect login form', () {
      emailInput = EmailInput.dirty('azimdjan18.com');
      passwordInput = PasswordInput.dirty('');
      loginForm = LoginForm(
        emailInput: emailInput,
        passwordInput: passwordInput,
      );
      expect(loginForm.status, FormzStatus.invalid);
    });
  });
}
