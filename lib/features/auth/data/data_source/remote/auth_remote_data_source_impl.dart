import 'dart:convert';

import 'package:ella/constants/constants.dart';
import 'package:ella/core/error/exceptions.dart';
import 'package:ella/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_request_model.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_response_model.dart';
import 'package:ella/features/auth/data/models/sign_up/Sign_up_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/sign_up_response_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  var requestOptions = Options(
    contentType: 'application/json',
    sendTimeout: 30,
  );

  @override
  Future<SignInResponseModel> signIn(
      SignInRequestModel signInRequestModel) async {
    try {
      final response = await dio.post(
        Constants.baseUrl + Urls.SIGN_IN_URL,
        data: jsonEncode(signInRequestModel.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SignInResponseModel.fromJson(response.data);
      } else {
        throw ServerException.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: Validations.SOMETHING_WENT_WRONG);
    }
  }

  @override
  Future<SignUpResponseModel> signUp(
      SignUpRequestModel signUpRequestModel) async {
    try {
      final response = await dio.post(
        Constants.baseUrl + Urls.SIGN_UP_URL,
        data: jsonEncode(
          signUpRequestModel.toJson(),
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SignUpResponseModel.fromJson(response.data);
      } else {
        throw ServerException.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: Validations.SOMETHING_WENT_WRONG);
    }
  }
}
