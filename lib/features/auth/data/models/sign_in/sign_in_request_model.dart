import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';

/// email : "jasmine@gmail.com"
/// password : "jasmine"

class SignInRequestModel {
  const SignInRequestModel({
    this.email,
    this.password,
  });

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

extension SignInRequestModelX on SignInRequestModel {
  SignInRequestEntity toEntity() => SignInRequestEntity(
        email: email,
        password: password,
      );
}
