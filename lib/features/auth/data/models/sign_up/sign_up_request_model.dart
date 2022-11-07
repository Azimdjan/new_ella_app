import 'package:ella/features/auth/domain/entities/sign_up/sign_up_request_entity.dart';

class SignUpRequestModel {
  const SignUpRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.language,
  });

  factory SignUpRequestModel.fromJson(dynamic json) {
    return SignUpRequestModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      language: json['language'],
    );
  }

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['language'] = language;
    return map;
  }
}

extension SignUpRequestModelX on SignUpRequestModel {
  SignUpRequestEntity toEntity() {
    return SignUpRequestEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      language: language,
    );
  }
}
