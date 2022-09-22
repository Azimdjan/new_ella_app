part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();

  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();

  @override
  List<Object?> get props => [];
}

class RegisterValidationError extends RegisterState {
  final String message;
  final RegisterInputErrors errors;

  const RegisterValidationError({
    required this.message,
    required this.errors,
  });

  @override
  List<Object?> get props => [message];
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();

  @override
  List<Object?> get props => [];
}

enum RegisterInputErrors {
  firstName,
  lastName,
  email,
  password,
  confirmPassword
}
