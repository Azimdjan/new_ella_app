import 'package:ella/core/error/failure.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_response_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/sign_in/sign_in_response_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, SignUpResponseEntity>> signUp(SignUpRequestEntity requestEntity);
  Future<Either<Failure, SignInResponseEntity>> signIn(SignInRequestEntity requestEntity);
}