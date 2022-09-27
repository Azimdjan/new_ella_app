import 'package:ella/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:flutter/cupertino.dart';

mixin RegisterMixin {
  late TextEditingController firstNameController;
  late FocusNode firstNameFocus;
  late TextEditingController lastNameController;
  late FocusNode lastNameFocus;
  late TextEditingController emailController;
  late FocusNode emailFocus;
  late TextEditingController passwordController;
  late FocusNode passwordFocus;
  late TextEditingController confirmPasswordController;
  late FocusNode confirmPasswordFocus;

  void initTextControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
  }

  void disposeTextControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }

  void requestFocusNode(RegisterInputErrors? errors) {
    switch (errors) {
      case RegisterInputErrors.firstName:
        firstNameFocus.requestFocus();
        break;
      case RegisterInputErrors.lastName:
        lastNameFocus.requestFocus();
        break;
      case RegisterInputErrors.email:
        emailFocus.requestFocus();
        break;
      case RegisterInputErrors.password:
        passwordFocus.requestFocus();
        break;
      case RegisterInputErrors.confirmPassword:
        confirmPasswordFocus.requestFocus();
        break;
      default:
    }
  }
}
