import 'package:bloc/bloc.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/inputs/email_input.dart';
import 'package:ella/core/inputs/password_input.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:ella/constants/constants.dart';
import '../../../domain/usecases/sign_in.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignIn signIn;

  LoginBloc({required this.signIn}) : super(LoginInitial()) {
    on<LoginEmailTyped>(_loginEmailTypedHandler);
    on<LoginPasswordTyped>(_loginPasswordTypedHandler);
    on<LoginButtonPressed>(_loginButtonPressedHandler);
  }

  void _loginEmailTypedHandler(
      LoginEmailTyped event, Emitter<LoginState> emit) {
    final email = EmailInput.dirty(event.email);
    switch (email.error) {
      case EmailInputError.empty:
        emit(
          const LoginTypedEmail(
            isValid: false,
            errorMessage: Validations.EMAIL_EMPTY,
          ),
        );
        break;
      case EmailInputError.notEmail:
        emit(
          const LoginTypedEmail(
            isValid: false,
            errorMessage: Validations.NOT_EMAIL,
          ),
        );
        break;
      default:
        emit(
          const LoginTypedEmail(
            isValid: true,
          ),
        );
        break;
    }
  }

  void _loginPasswordTypedHandler(
      LoginPasswordTyped event, Emitter<LoginState> emit) {
    final password = PasswordInput.dirty(event.password);
    switch (password.error) {
      case PasswordInputError.empty:
        emit(
          const LoginTypedPassword(
            isValid: false,
            errorMessage: Validations.PASSWORD_EMPTY,
          ),
        );
        break;
      case PasswordInputError.short:
        emit(
          const LoginTypedPassword(
            isValid: false,
            errorMessage: Validations.PASSWORD_SHORT,
          ),
        );
        break;
      case PasswordInputError.long:
        emit(
          const LoginTypedPassword(
            isValid: false,
            errorMessage: Validations.PASSWORD_LONG,
          ),
        );
        break;
      default:
        emit(const LoginTypedPassword(isValid: true));
    }
  }

  void _loginButtonPressedHandler(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    final request = SignInRequestEntity(
      email: event.email,
      password: event.password,
    );
    emit(const LoginLoading());
    final response = await signIn(
      Params(signInRequestEntity: request),
    );
    response.fold(
      (error) => emit(
        LoginError(
          message: (error is ServerFailure) ? error.message : Validations.INTERNET_FAILURE,
        ),
      ),
      (response) => emit(
        LoginSuccess(),
      ),
    );
  }
}
