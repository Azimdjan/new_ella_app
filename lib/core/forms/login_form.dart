import 'package:ella/core/inputs/email_input.dart';
import 'package:ella/core/inputs/password_input.dart';
import 'package:formz/formz.dart';

class LoginForm with FormzMixin {
  final EmailInput emailInput;
  final PasswordInput passwordInput;

  LoginForm({
    required this.emailInput,
    required this.passwordInput,
  });

  @override
  List<FormzInput> get inputs => [
        emailInput,
        passwordInput,
      ];
}
