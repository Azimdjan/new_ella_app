import 'package:ella/features/auth/domain/entities/sign_in/sign_in_response_entity.dart';

/// token : "7430c4fc-79d2-48b4-9b45-81d3377d7f44"
/// first_name : "Jasmine"
/// last_name : "Cameron"

class SignInResponseModel extends SignInResponseEntity {
  const SignInResponseModel({
    this.token,
    this.firstName,
    this.lastName,
  }) : super(
          token: token,
          firstName: firstName,
          lastName: lastName,
        );

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
