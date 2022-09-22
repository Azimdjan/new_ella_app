import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ella/constants/constants.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_response_model.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_request_entity.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_response_entity.dart';
import 'package:ella/features/auth/domain/usecases/sign_in.dart';
import 'package:ella/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'login_bloc_test.mocks.dart';

@GenerateMocks([SignIn])
void main() {
  late SignIn signIn;
  late LoginBloc loginBloc;

  setUp(() {
    signIn = MockSignIn();
    loginBloc = LoginBloc(
      signIn: signIn,
    );
  });

  group('test email login bloc', () {
    var email1 = "azimdjan18gmail.com";
    blocTest<LoginBloc, LoginState>(
      'email validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginEmailTyped(
          email: email1,
        ),
      ),
      expect: () => <LoginState>[
        const LoginTypedEmail(isValid: false, errorMessage: Validations.NOT_EMAIL),
      ],
    );

    var email2 = "";
    blocTest<LoginBloc, LoginState>(
      'email validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginEmailTyped(
          email: email2,
        ),
      ),
      expect: () => <LoginState>[
        const LoginTypedEmail(isValid: false, errorMessage: Validations.EMAIL_EMPTY),
      ],
    );

    var email3 = "azimdjan18@gmail.com";
    blocTest<LoginBloc, LoginState>(
      'email validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginEmailTyped(
          email: email3,
        ),
      ),
      expect: () => <LoginState>[
        const LoginTypedEmail(isValid: true),
      ],
    );
  });

  group('test password login bloc', () {
    var password1 = "a3332";
    blocTest<LoginBloc, LoginState>(
      'password validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginPasswordTyped(
          password: password1,
        ),
      ),
      expect: () => <LoginState>[
        const LoginTypedPassword(isValid: false, errorMessage: Validations.PASSWORD_SHORT),
      ],
    );

    var password2 = "";
    blocTest<LoginBloc, LoginState>(
      'password validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginPasswordTyped(
          password: password2,
        ),
      ),
      expect: () => <LoginState>[
        const LoginTypedPassword(isValid: false, errorMessage: Validations.PASSWORD_EMPTY),
      ],
    );

    var password3 = "dfkdjakfljdsaklfjdslak;fjlkadjfjfldkjl";
    blocTest<LoginBloc, LoginState>(
      'password validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginPasswordTyped(
          password: password3,
        ),
      ),
      expect: () => <LoginState>[
        const LoginTypedPassword(isValid: false, errorMessage: Validations.PASSWORD_LONG),
      ],
    );

    var password4 = "dfkdjakfljds";
    blocTest<LoginBloc, LoginState>(
      'password validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginPasswordTyped(
          password: password4,
        ),
      ),
      expect: () => <LoginState>[
        const LoginTypedPassword(isValid: true),
      ],
    );
  });

  group('test sign in function', () {
    late SignInRequestEntity signInRequestEntity;
    late SignInResponseEntity signInResponseEntity;
    setUp(() {
      signInRequestEntity = const SignInRequestEntity(
        email: "azimdjan18@gmail.com",
        password: "a3213354",
      );
      signInResponseEntity = SignInResponseModel.fromJson(
        jsonDecode(
          fixture('sign_in_response_fixture'),
        ),
      );
    });

    blocTest<LoginBloc, LoginState>(
      'sign in error',
      build: () {
        when(signIn.call(Params(signInRequestEntity: signInRequestEntity)))
            .thenAnswer(
          (realInvocation) async => Left(
            ServerFailure(message: 'Some thing went wrong'),
          ),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(
        LoginButtonPressed(
          email: signInRequestEntity.email ?? '',
          password: signInRequestEntity.password ?? '',
        ),
      ),
      expect: () => <LoginState>[
        const LoginLoading(),
        const LoginError(message: 'Some thing went wrong'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'test sign in no internet',
      build: () {
        when(signIn.call(Params(signInRequestEntity: signInRequestEntity)))
            .thenAnswer(
          (realInvocation) async => Left(
            NoInternetFailure(),
          ),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(
        LoginButtonPressed(
            email: signInRequestEntity.email ?? '',
            password: signInRequestEntity.password ?? ''),
      ),
      expect: () => <LoginState>[
        const LoginLoading(),
        const LoginError(message: Validations.INTERNET_FAILURE),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'test sign in successfully',
      build: () {
        when(signIn.call(Params(signInRequestEntity: signInRequestEntity)))
            .thenAnswer(
          (realInvocation) async => Right(
            signInResponseEntity,
          ),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(
        LoginButtonPressed(
            email: signInRequestEntity.email ?? '',
            password: signInRequestEntity.password ?? ''),
      ),
      expect: () => <LoginState>[
        const LoginLoading(),
        LoginSuccess(),
      ],
    );
  });
}
