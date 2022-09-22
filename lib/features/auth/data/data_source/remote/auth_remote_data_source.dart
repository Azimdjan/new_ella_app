import 'package:ella/features/auth/data/models/sign_in/sign_in_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/Sign_up_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/sign_up_response_model.dart';

import '../../models/sign_in/sign_in_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignInResponseModel> signIn(SignInRequestModel signInRequestModel);

  Future<SignUpResponseModel> signUp(SignUpRequestModel signUpRequestModel);
}
