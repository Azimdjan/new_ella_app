import 'dart:convert';

import 'package:ella/constants/constants.dart';
import 'package:ella/core/error/exceptions.dart';
import 'package:ella/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_request_model.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_response_model.dart';
import 'package:ella/features/auth/data/models/sign_up/Sign_up_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/sign_up_response_model.dart';
import 'package:dio/dio.dart';

const SIGN_IN_URL = '/v1/users/sign_in/';
const SIGN_UP_URL = '/v1/users/sign_up/';

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
    final response = await dio.post(
      Constants.baseUrl + SIGN_IN_URL,
      data: jsonEncode(signInRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      return SignInResponseModel.fromJson(
        jsonDecode(response.data),
      );
    } else {
      throw ServerException(message: '${response.data}');
    }
  }

  @override
  Future<SignUpResponseModel> signUp(
      SignUpRequestModel signUpRequestModel) async {
    final response = await dio.post(
      Constants.baseUrl + SIGN_UP_URL,
      data: jsonEncode(
        signUpRequestModel.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      return SignUpResponseModel.fromJson(
        jsonDecode(response.data),
      );
    } else {
      throw ServerException(
        message: response.data.toString(),
      );
    }
  }
}
