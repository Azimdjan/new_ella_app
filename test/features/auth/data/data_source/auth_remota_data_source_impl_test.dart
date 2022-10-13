import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ella/constants/constants.dart';
import 'package:ella/core/error/exceptions.dart';
import 'package:ella/features/auth/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_request_model.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_response_model.dart';
import 'package:ella/features/auth/data/models/sign_up/Sign_up_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/sign_up_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'auth_remota_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late Dio dio;
  late AuthRemoteDataSourceImpl authRepositoryImpl;
  late SignInRequestModel signInRequestModel;
  late SignUpRequestModel signUpRequestModel;
  late SignInResponseModel signInResponseModel;
  late SignUpResponseModel signUpResponseModel;

  setUp(() {
    dio = MockDio();
    authRepositoryImpl = AuthRemoteDataSourceImpl(dio);
    signInRequestModel = SignInRequestModel.fromJson(
        jsonDecode(fixture('sign_in_request_fixture')));
    signUpRequestModel = SignUpRequestModel.fromJson(
        jsonDecode(fixture('sign_up_request_fixture')));
    signInResponseModel = SignInResponseModel.fromJson(
        jsonDecode(fixture('sign_in_response_fixture')));
    signUpResponseModel = SignUpResponseModel.fromJson(
        jsonDecode(fixture('sign_up_response_fixture')));
  });

  test('verify sign in api is called successfully', () async {
    final data = fixture('sign_in_response_fixture');
    Response response = Response(
      requestOptions: RequestOptions(
        path: Urls.SIGN_IN_URL,
        baseUrl: Constants.baseUrl,
        data: data,
      ),
      data: data,
      statusCode: 200,
    );
    when(dio.post(Constants.baseUrl + Urls.SIGN_IN_URL,
            data: jsonEncode(signInRequestModel.toJson())))
        .thenAnswer(
      (_) async => response,
    );
    final result = await authRepositoryImpl.signIn(signInRequestModel);
    verify(
      dio.post(
        Constants.baseUrl + Urls.SIGN_IN_URL,
        data: jsonEncode(signInRequestModel.toJson()),
      ),
    );
    expect(result, signInResponseModel);
  });

  test('verify sign in api is called with 400 error', () async {
    Response response = Response(
      requestOptions: RequestOptions(
        path: Urls.SIGN_IN_URL,
        baseUrl: Constants.baseUrl,
      ),
      data: "Something went wrong",
      statusCode: 400,
    );
    when(dio.post(Constants.baseUrl + Urls.SIGN_IN_URL,
            data: jsonEncode(signInRequestModel.toJson())))
        .thenAnswer(
      (_) async => response,
    );
    final call = authRepositoryImpl.signIn;

    expect(
      () => call(signInRequestModel),
      throwsA(
        const TypeMatcher<ServerException>(),
      ),
    );
  });

  test('verify sign up api is called successfully', () async {
    final response = Response(
      requestOptions: RequestOptions(
        baseUrl: Constants.baseUrl,
        path: Urls.SIGN_UP_URL,
      ),
      data: fixture('sign_up_response_fixture'),
      statusCode: 200,
    );
    when(dio.post(Constants.baseUrl + Urls.SIGN_UP_URL,
            data: jsonEncode(signUpRequestModel.toJson())))
        .thenAnswer((realInvocation) async => response);
    final result = await authRepositoryImpl.signUp(signUpRequestModel);
    verify(dio.post(Constants.baseUrl + Urls.SIGN_UP_URL,
        data: jsonEncode(signUpRequestModel.toJson())));
    expect(result, signUpResponseModel);
  });

  test('verify sign up api is called with 400 error', () {
    final response = Response(
      requestOptions: RequestOptions(
        baseUrl: Constants.baseUrl,
        path: Urls.SIGN_UP_URL,
      ),
      data: "Something went wrong",
      statusCode: 400,
    );
    when(dio.post(Constants.baseUrl + Urls.SIGN_UP_URL,
            data: jsonEncode(signUpRequestModel.toJson())))
        .thenAnswer((realInvocation) async => response);
    final call = authRepositoryImpl.signUp;
    expect(
      () => call(signUpRequestModel),
      throwsA(
        const TypeMatcher<ServerException>(),
      ),
    );
  });
}
