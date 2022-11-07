import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ella/core/error/exceptions.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/platform/network_info.dart';
import 'package:ella/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:ella/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_request_model.dart';
import 'package:ella/features/auth/data/models/sign_in/sign_in_response_model.dart';
import 'package:ella/features/auth/data/models/sign_up/Sign_up_request_model.dart';
import 'package:ella/features/auth/data/models/sign_up/sign_up_response_model.dart';
import 'package:ella/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ella/features/auth/domain/entities/sign_in/sign_in_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([
  AuthRemoteDataSource,
  AuthLocalDataSource,
  NetworkInfo,
])
void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRemoteDataSource authRemoteDataSource;
  late MockAuthLocalDataSource authLocalDataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    authLocalDataSource = MockAuthLocalDataSource();
    authRemoteDataSource = MockAuthRemoteDataSource();
    networkInfo = MockNetworkInfo();
    authRepositoryImpl = AuthRepositoryImpl(
      authLocalDataSource: authLocalDataSource,
      authRemoteDataSource: authRemoteDataSource,
      networkInfo: networkInfo,
    );
  });

  group('sign in online', () {
    const signInRequestModel = SignInRequestModel(
      email: 'email',
      password: 'password',
    );
    const signInResponseModel = SignInResponseModel(
      token: 'token',
      firstName: 'firstName',
      lastName: 'lastName',
    );
    final SignInResponseEntity signInResponseEntity =
        signInResponseModel.toEntity();

    setUp(() {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
    });

    test('should return right sign in entity', () async {
      when(authRemoteDataSource.signIn(signInRequestModel))
          .thenAnswer((realInvocation) async => signInResponseModel);
      final result =
          await authRepositoryImpl.signIn(signInRequestModel.toEntity());
      verify(authRemoteDataSource.signIn(signInRequestModel));
      expect(
        result,
        Right(signInResponseEntity),
      );
    });

    test('should return left failure', () async {
      when(authRemoteDataSource.signIn(signInRequestModel))
          .thenThrow(ServerException(message: 'Something went wrong'));
      final result =
          await authRepositoryImpl.signIn(signInRequestModel.toEntity());
      verify(authRemoteDataSource.signIn(signInRequestModel));
      verifyNoMoreInteractions(authRemoteDataSource);
      expect(
        result,
        Left(
          ServerFailure(message: 'Something went wrong'),
        ),
      );
    });
  });

  group('sign in online', () {
    const signInRequestModel = SignInRequestModel(
      email: 'email',
      password: 'password',
    );

    setUp(() => when(networkInfo.isConnected)
        .thenAnswer((realInvocation) async => false));

    test('should return no internet failure', () async {
      when(authRemoteDataSource.signIn(signInRequestModel))
          .thenThrow(NoInternetException());
      final result =
          await authRepositoryImpl.signIn(signInRequestModel.toEntity());
      verifyNever(authRemoteDataSource.signIn(signInRequestModel));
      verifyNoMoreInteractions(authRemoteDataSource);
      expect(result, equals(Left(NoInternetFailure())));
    });
  });

  group('sign up online', () {
    final signUpRequestModel = SignUpRequestModel.fromJson(
      jsonDecode(
        fixture('sign_up_request_fixture'),
      ),
    );
    final signUpResponseModel = SignUpResponseModel.fromJson(
      jsonDecode(
        fixture('sign_up_response_fixture'),
      ),
    );

    setUp(() => when(networkInfo.isConnected)
        .thenAnswer((realInvocation) async => true));

    test('should return correct model', () async {
      when(authRemoteDataSource.signUp(signUpRequestModel))
          .thenAnswer((realInvocation) async => signUpResponseModel);
      final result = await authRepositoryImpl.signUp(signUpRequestModel);
      verify(authRemoteDataSource.signUp(signUpRequestModel));
      verifyNoMoreInteractions(authRemoteDataSource);
      expect(result, Right(signUpResponseModel));
    });

    test('should return failure', () async {
      when(authRemoteDataSource.signUp(signUpRequestModel)).thenThrow(
        ServerException(message: 'Something went wrong'),
      );
      final result = await authRepositoryImpl.signUp(signUpRequestModel);
      verify(authRemoteDataSource.signUp(signUpRequestModel));
      verifyNoMoreInteractions(authRemoteDataSource);
      expect(result, Left(ServerFailure(message: 'Something went wrong')));
    });
  });

  group('sign up offline', () {
    final signUpRequestModel = SignUpRequestModel.fromJson(
      jsonDecode(
        fixture('sign_up_request_fixture'),
      ),
    );

    setUp(
      () => when(networkInfo.isConnected)
          .thenAnswer((realInvocation) async => false),
    );

    test('should return no internet failure', () async {
      when(authRemoteDataSource.signUp(signUpRequestModel))
          .thenThrow(NoInternetException());
      final result = await authRepositoryImpl.signUp(signUpRequestModel);
      verifyNever(authRemoteDataSource.signUp(signUpRequestModel));
      verifyNoMoreInteractions(authRemoteDataSource);
      expect(result, Left(NoInternetFailure()));
    });
  });
}
