import 'package:ella/features/auth/domain/entities/sign_up/sign_up_response_entity.dart';

/// token : "7430c4fc-79d2-48b4-9b45-81d3377d7f44"

class SignUpResponseModel {
  const SignUpResponseModel({
    this.token,
  });

  factory SignUpResponseModel.fromJson(dynamic json) {
    return SignUpResponseModel(
      token: json['token'],
    );
  }

  final String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }
}

extension SignUpResponseModelX on SignUpResponseModel {
  SignUpResponseEntity toEntity() {
    return SignUpResponseEntity(
      token: token,
    );
  }
}
