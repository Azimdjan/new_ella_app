import 'package:dartz/dartz.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_response_entity.dart';
import 'package:ella/features/auth/domain/repository/auth_repository.dart';
import 'package:ella/features/auth/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'sign_in_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignIn useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignIn(mockAuthRepository);
  });

  const signInRequest =
      SignInRequestEntity(email: 'azimdjan18@gmail.com', password: 'a3213354');
  const signInResponse = SignInResponseEntity(
      token: 'token', firstName: 'firstName', lastName: 'lastName');

  test('should sign in for given request from repository', () async {
    when(mockAuthRepository.signIn(signInRequest))
        .thenAnswer((_) async => const Right(signInResponse));

    final result = await useCase(
      const Params(signInRequestEntity: signInRequest),
    );

    expect(result, const Right(signInResponse));

    verify(mockAuthRepository.signIn(signInRequest));

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
