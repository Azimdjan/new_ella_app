import 'package:ella/core/mixins/login_mixin.dart';
import 'package:ella/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:ella/features/auth/presentation/pages/login/widgets/sign_up_types.dart';
import 'package:ella/features/auth/presentation/pages/login/widgets/welcome_texts.dart';
import 'package:ella/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../router/name_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  void initState() {
    initTextControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
          }
          if (state is LoginSuccess) {
            context.go(Routes.home);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoginLoading,
            opacity: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 46,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    WelcomeText(
                      title: localization.welcomeBack,
                      subtitle: localization.welcomeBackSubtitle,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextField(
                      controller: emailController,
                      validator: (value) {},
                      textInputType: TextInputType.emailAddress,
                      onChanged: (email) {
                        context.read<LoginBloc>().add(
                              LoginEmailTyped(email: email),
                            );
                      },
                      focusNode: emailFocus,
                      textCapitalization: TextCapitalization.none,
                      hintText: localization.enterEmail,
                      nextFocusNode: passwordFocus,
                      labelText: localization.email,
                      labelTextStyle:
                          Theme.of(context).primaryTextTheme.bodyText2,
                      errorText: (state is LoginTypedEmail)
                          ? state.errorMessage
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      validator: (value) {
                        return null;
                      },
                      onChanged: (password) {
                        context.read<LoginBloc>().add(
                              LoginPasswordTyped(
                                password: password,
                              ),
                            );
                      },
                      focusNode: passwordFocus,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.none,
                      hintText: localization.enterPassword,
                      labelText: localization.password,
                      obscure: true,
                      labelTextStyle:
                          Theme.of(context).primaryTextTheme.bodyText2,
                      errorText: (state is LoginTypedPassword)
                          ? state.errorMessage
                          : null,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          localization.forgotPassword,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    ElevatedButton(
                      onPressed: (state is LoginTypedEmail)
                          ? state.isValid
                              ? () {
                                  context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                }
                              : null
                          : (state is LoginTypedPassword)
                              ? state.isValid
                                  ? () {
                                      context.read<LoginBloc>().add(
                                            LoginButtonPressed(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            ),
                                          );
                                    }
                                  : null
                              : () {
                                  context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                },
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            localization.signIn,
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
                    if (MediaQuery.of(context).viewInsets.bottom == 0)
                      SignUpTypes(
                        emailOnTap: () {
                          context.push(Routes.register);
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    disposeTextControllers();
    super.dispose();
  }
}
