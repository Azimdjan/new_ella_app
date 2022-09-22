import 'package:equatable/equatable.dart';

class SignUpResponseEntity extends Equatable {
  final String? token;

  const SignUpResponseEntity({required this.token});

  @override
  List<Object?> get props => [token];
}
