import 'package:flutter/material.dart';

mixin LoginMixin {
  late TextEditingController emailController;
  late FocusNode emailFocus;
  late TextEditingController passwordController;
  late FocusNode passwordFocus;

  void initTextControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  void disposeTextControllers() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }
}
