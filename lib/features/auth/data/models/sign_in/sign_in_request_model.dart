import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';

/// email : "jasmine@gmail.com"
/// password : "jasmine"

class SignInRequestModel extends SignInRequestEntity {
  const SignInRequestModel({
    this.email,
    this.password,
  }) : super(
          email: email,
          password: password,
        );

  factory SignInRequestModel.fromJson(dynamic json) {
    return SignInRequestModel(
      email: json['email'],
      password: json['password'],
    );
  }

  final String? email;
  final String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
