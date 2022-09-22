import '../../constants/constants.dart';
import '../../features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import '../inputs/email_input.dart';
import '../inputs/name_input.dart';
import '../inputs/password_input.dart';

mixin RegisterValidation {
  Map<RegisterInputErrors, String>? validateRegister(
    NameInput firstName,
    NameInput lastName,
    EmailInput email,
    PasswordInput password,
    String confirmPassword,
  ) {
    if (firstName.error == null &&
        lastName.error == null &&
        email.error == null &&
        password.error == null &&
        password.value == confirmPassword) {
      return null;
    }
    final isValidFirstName = firstNameValidation(firstName);
    if (isValidFirstName != null) {
      return isValidFirstName;
    }
    final isValidLastName = lastNameValidation(lastName);
    if (isValidLastName != null) {
      return isValidLastName;
    }
    final isValidEmail = emailValidation(email);
    if (isValidEmail != null) {
      return isValidEmail;
    }
    final isValidPassword = passwordValidation(password);
    if (isValidPassword != null) {
      return isValidPassword;
    }
    final isPasswordsMatch = passwordsMatch(password.value, confirmPassword);
    if(isPasswordsMatch != null) {
      return isPasswordsMatch;
    } else {
      return null;
    }
  }

  Map<RegisterInputErrors, String>? passwordsMatch(
    String password,
    String confirmPassword,
  ) {
    if (password != confirmPassword) {
      return {
        RegisterInputErrors.confirmPassword: Validations.PASSWORD_NOT_MATCH
      };
    } else {
      return null;
    }
  }

  Map<RegisterInputErrors, String>? firstNameValidation(NameInput firstName) {
    switch (firstName.error) {
      case NameInputError.empty:
        return {RegisterInputErrors.firstName: Validations.FIRSTNAME_EMPTY};
      case NameInputError.short:
        return {RegisterInputErrors.firstName: Validations.FIRSTNAME_SHORT};
      case NameInputError.long:
        return {RegisterInputErrors.firstName: Validations.FIRSTNAME_LONG};
      default:
        return null;
    }
  }

  Map<RegisterInputErrors, String>? lastNameValidation(NameInput lastName) {
    switch (lastName.error) {
      case NameInputError.empty:
        return {RegisterInputErrors.lastName: Validations.LASTNAME_EMPTY};
      case NameInputError.short:
        return {RegisterInputErrors.lastName: Validations.LASTNAME_SHORT};
      case NameInputError.long:
        return {RegisterInputErrors.lastName: Validations.LASTNAME_LONG};
      default:
        return null;
    }
  }

  Map<RegisterInputErrors, String>? emailValidation(EmailInput email) {
    switch (email.error) {
      case EmailInputError.empty:
        return {RegisterInputErrors.email: Validations.EMAIL_EMPTY};
      case EmailInputError.notEmail:
        return {RegisterInputErrors.email: Validations.NOT_EMAIL};
      default:
        return null;
    }
  }

  Map<RegisterInputErrors, String>? passwordValidation(PasswordInput password) {
    switch (password.error) {
      case PasswordInputError.empty:
        return {RegisterInputErrors.password: Validations.PASSWORD_EMPTY};
      case PasswordInputError.short:
        return {RegisterInputErrors.password: Validations.PASSWORD_SHORT};
      case PasswordInputError.long:
        return {RegisterInputErrors.password: Validations.PASSWORD_LONG};
      default:
        return null;
    }
  }
}
