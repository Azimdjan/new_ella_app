import 'package:dartz/dartz.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_up/sign_up_response_entity.dart';
import 'package:ella/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_test.mocks.dart';

void main() {
  late SignUp useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignUp(mockAuthRepository);
  });

  const signUpRequest = SignUpRequestEntity(
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    password: 'password',
    language: 'uz',
  );
  const signUpResponse = SignUpResponseEntity(
    token: 'token',
  );

  test('should sign up for given request for repository', () async {
    when(mockAuthRepository.signUp(signUpRequest)).thenAnswer(
      (realInvocation) async => const Right(signUpResponse),
    );

    final result = await useCase(const Params(signUpRequest));

    expect(result, const Right(signUpResponse));

    verify(mockAuthRepository.signUp(signUpRequest));

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
