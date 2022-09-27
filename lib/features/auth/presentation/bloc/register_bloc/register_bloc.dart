import 'package:bloc/bloc.dart';
import 'package:ella/constants/constants.dart';
import 'package:ella/core/inputs/email_input.dart';
import 'package:ella/core/inputs/name_input.dart';
import 'package:ella/core/inputs/password_input.dart';
import 'package:ella/core/mixins/register_validation.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_request_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/sign_up.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>
    with RegisterValidation {
  final SignUp signUp;

  RegisterBloc({required this.signUp})
      : super(const RegisterState(status: RegisterStatus.initial)) {
    on<RegisterButtonPressed>(_registerButtonPressedHandler);
  }

  void _registerButtonPressedHandler(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    final firstName = NameInput.dirty(event.firstName.trim());
    final lastName = NameInput.dirty(event.lastName.trim());
    final email = EmailInput.dirty(event.email.trim());
    final password = PasswordInput.dirty(event.password.trim());
    final confirmPassword = event.confirmPassword.trim();
    emit(const RegisterState(status: RegisterStatus.loading));
    Map<RegisterInputErrors, String>? errorMessage = validateRegister(
      firstName,
      lastName,
      email,
      password,
      confirmPassword,
    );
    if (errorMessage == null) {
      final request = SignUpRequestEntity(
        firstName: firstName.value,
        lastName: lastName.value,
        email: email.value,
        password: password.value,
        language: 'en',
      );
      final response = await signUp(Params(request));
      response.fold(
        (error) => emit(
          RegisterState(
            status: RegisterStatus.error,
            message: (error is ServerFailure)
                ? error.message
                : Validations.INTERNET_FAILURE,
          ),
        ),
        (response) => emit(
          const RegisterState(status: RegisterStatus.success),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          message: errorMessage.values.first,
          errors: errorMessage.keys.first,
        ),
      );
    }
  }
}
