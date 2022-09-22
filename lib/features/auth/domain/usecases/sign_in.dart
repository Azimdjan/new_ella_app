import 'package:ella/core/error/failure.dart';
import 'package:ella/core/usecase/usecase.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_response_entity.dart';
import 'package:ella/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UseCase<SignInResponseEntity, Params> {
  final AuthRepository authRepository;

  SignIn(this.authRepository);

  @override
  Future<Either<Failure, SignInResponseEntity>> call(Params params) async {
    final response = await authRepository.signIn(params.signInRequestEntity);
    return response;
  }
}

class Params extends Equatable {
  final SignInRequestEntity signInRequestEntity;

  const Params({required this.signInRequestEntity});

  @override
  List<Object?> get props => [signInRequestEntity];
}
