part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginTypedEmail extends LoginState {
  final bool isValid;
  final String? errorMessage;

  const LoginTypedEmail({required this.isValid, this.errorMessage});

  @override
  List<Object?> get props => [isValid, errorMessage];
}

class LoginTypedPassword extends LoginState {
  final bool isValid;
  final String? errorMessage;

  const LoginTypedPassword({required this.isValid, this.errorMessage});

  @override
  List<Object?> get props => [isValid, errorMessage];
}

class LoginLoading extends LoginState {
  const LoginLoading();
  @override
  List<Object?> get props => [];
}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}
