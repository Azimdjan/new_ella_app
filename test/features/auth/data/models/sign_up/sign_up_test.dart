import 'dart:convert';

import 'package:ella/features/auth/data/models/sign_up/Sign_up_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/sign_up_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const signUpResponseModel = SignUpResponseModel(
    token: '7430c4fc-79d2-48b4-9b45-81d3377d7f44',
  );
  final signUpRequestMap = jsonDecode(
    fixture('sign_up_request_fixture'),
  );

  test('fromJson sign up response', () {
    final jsonMap = jsonDecode(
      fixture('sign_up_response_fixture'),
    );
    final result = SignUpResponseModel.fromJson(jsonMap);
    expect(result, signUpResponseModel);
  });

  test('to json sign up request', () {
    const signUpRequestModel = SignUpRequestModel(
      firstName: 'Jasmine',
      lastName: 'Malh',
      email: 'jasmine@gmail.com',
      password: '11119999',
      language: 'uz',
    );
    final result = signUpRequestModel.toJson();
    expect(result, signUpRequestMap);
  });
}
