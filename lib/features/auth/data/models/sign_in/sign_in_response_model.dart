import 'package:ella/features/auth/domain/entities/sign_in/sign_in_response_entity.dart';

/// token : "7430c4fc-79d2-48b4-9b45-81d3377d7f44"
/// first_name : "Jasmine"
/// last_name : "Cameron"

class SignInResponseModel {
  const SignInResponseModel({
    this.token,
    this.firstName,
    this.lastName,
  });

  factory SignInResponseModel.fromJson(dynamic json) {
    return SignInResponseModel(
      token: json['token'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  final String? token;
  final String? firstName;
  final String? lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    return map;
  }
}

extension SignInResponseModelExtension on SignInResponseModel {
  SignInResponseEntity toEntity() {
    return SignInResponseEntity(
      token: token,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
