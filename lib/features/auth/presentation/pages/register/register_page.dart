import 'package:ella/core/mixins/register_mixin.dart';
import 'package:ella/core/widgets/custom_text_field.dart';
import 'package:ella/features/auth/presentation/pages/login/widgets/welcome_texts.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  void initState() {
    initTextControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const WelcomeText(
                title: 'Nunquam acquirere racana.',
                subtitle:
                    'All honorable moons love each other, only great suns have a grace.',
              ),
              const SizedBox(
                height: 32,
              ),
              CustomTextField(
                controller: firstNameController,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {},
                textInputType: TextInputType.name,
                focusNode: firstNameFocus,
                textCapitalization: TextCapitalization.words,
                hintText: "Enter first name",
                nextFocusNode: lastNameFocus,
                labelText: "First Name",
                labelTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: lastNameController,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {},
                textInputType: TextInputType.name,
                focusNode: lastNameFocus,
                textCapitalization: TextCapitalization.words,
                hintText: "Enter last name",
                nextFocusNode: emailFocus,
                labelText: "Last Name",
                labelTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: emailController,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {},
                textInputType: TextInputType.emailAddress,
                focusNode: emailFocus,
                textCapitalization: TextCapitalization.words,
                hintText: "Enter email",
                nextFocusNode: passwordFocus,
                labelText: "Email",
                labelTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {},
                focusNode: passwordFocus,
                textInputType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
                hintText: "Enter password",
                nextFocusNode: confirmPasswordFocus,
                labelText: "Password",
                obscure: true,
                labelTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: confirmPasswordController,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {},
                focusNode: confirmPasswordFocus,
                textInputType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
                hintText: "Enter confirm password",
                textInputAction: TextInputAction.done,
                labelText: "Confirm Password",
                obscure: true,
                labelTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              const SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2
                          ?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposeTextControllers();
    super.dispose();
  }
}
