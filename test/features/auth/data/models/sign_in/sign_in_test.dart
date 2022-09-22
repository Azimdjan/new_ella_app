import 'dart:convert';

import 'package:ella/features/auth/data/models/sign_in/sign_in_request_model.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const signInResponse = SignInResponseModel(
    token: "7430c4fc-79d2-48b4-9b45-81d3377d7f44",
    firstName: "Jasmine",
    lastName: "Cameron",
  );
  final signInRequestJsonMap = jsonDecode(fixture("sign_in_request_fixture"));

  test('fromJson sign in response', () {
    final mapJson = jsonDecode(fixture('sign_in_response_fixture'));
    final result = SignInResponseModel.fromJson(mapJson);
    expect(result, signInResponse);
  });

  test('toJson sign in request', () {
    const signInRequestModel = SignInRequestModel(
      email: "jasmine@gmail.com",
      password: "jasmine",
    );
    final result = signInRequestModel.toJson();
    expect(result, signInRequestJsonMap);
  });
}
