part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailTyped extends LoginEvent {
  final String email;

  const LoginEmailTyped({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class LoginPasswordTyped extends LoginEvent {
  final String password;

  const LoginPasswordTyped({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
