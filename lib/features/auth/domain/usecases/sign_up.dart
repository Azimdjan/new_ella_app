import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/usecase/usecase.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_response_entity.dart';
import 'package:ella/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UseCase<SignUpResponseEntity, Params> {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  @override
  Future<Either<Failure, SignUpResponseEntity>> call(Params params) async {
    final response = await authRepository.signUp(params.signUpRequestEntity);
    return response;
  }
}

class Params extends Equatable {
  final SignUpRequestEntity signUpRequestEntity;

  const Params(this.signUpRequestEntity);

  @override
  List<Object?> get props => [signUpRequestEntity];
}
