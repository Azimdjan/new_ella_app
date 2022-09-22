import 'package:equatable/equatable.dart';

class SignInResponseEntity extends Equatable {
  final String? token;
  final String? firstName;
  final String? lastName;

  const SignInResponseEntity({
    required this.token,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [
        token,
        firstName,
        lastName,
      ];
}
