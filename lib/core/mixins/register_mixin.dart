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
}
