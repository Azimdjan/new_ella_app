import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/platform/network_info.dart';
import 'package:ella/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:ella/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/Sign_up_request_model.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_response_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_response_entity.dart';
import 'package:ella/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SignInResponseEntity>> signIn(
      SignInRequestEntity requestEntity) async {
    final request = SignInRequestModel(
      email: requestEntity.email,
      password: requestEntity.password,
    );
    if (await networkInfo.isConnected) {
      try {
        final response = await authRemoteDataSource.signIn(request);
        return Right(response);
      } catch (e) {
        return Left(
          ServerFailure(
            message: e.toString(),
          ),
        );
      }
    } else {
      return Left(
        NoInternetFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, SignUpResponseEntity>> signUp(
      SignUpRequestEntity requestEntity) async {
    final signUpRequestModel = SignUpRequestModel(
      firstName: requestEntity.firstName,
      lastName: requestEntity.lastName,
      email: requestEntity.email,
      password: requestEntity.password,
      language: requestEntity.language,
    );
    if (await networkInfo.isConnected) {
      try {
        final response = await authRemoteDataSource.signUp(signUpRequestModel);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
