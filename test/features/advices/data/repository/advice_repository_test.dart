import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ella/core/error/exceptions.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/platform/network_info.dart';
import 'package:ella/features/advices/data/data_source/local/advice_local_data_source.dart';
import 'package:ella/features/advices/data/data_source/remote/advice_remote_data_source.dart';
import 'package:ella/features/advices/data/models/article/article_response.dart';
import 'package:ella/features/advices/data/models/category_list/category_list_response.dart';
import 'package:ella/features/advices/data/models/guid_list/guid_list_response.dart';
import 'package:ella/features/advices/data/repository/advice_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'advice_repository_test.mocks.dart';

@GenerateMocks([
  AdviceRemoteDataSource,
  AdviceLocalDataSource,
  NetworkInfo,
])
void main() {
  late final AdviceRemoteDataSource adviceRemoteDataSource;
  late final AdviceLocalDataSource adviceLocalDataSource;
  late final NetworkInfo networkInfo;
  late final CategoryListResponse categoryListResponse;
  late final GuidResponse guidListResponse;
  late final ArticleResponse articleResponse;
  late final AdviceRepositoryImpl adviceRepositoryImpl;

  setUpAll(() {
    adviceRemoteDataSource = MockAdviceRemoteDataSource();
    adviceLocalDataSource = MockAdviceLocalDataSource();
    networkInfo = MockNetworkInfo();
    adviceRepositoryImpl = AdviceRepositoryImpl(
      adviceRemoteDataSource: adviceRemoteDataSource,
      adviceLocalDataSource: adviceLocalDataSource,
      networkInfo: networkInfo,
    );
    categoryListResponse = CategoryListResponse.fromJson(
      jsonDecode(
        fixture('get_category_list_fixture', 'advices'),
      ),
    );
    guidListResponse = GuidResponse.fromJson(
      jsonDecode(
        fixture('get_guid_list_fixture', 'advices'),
      ),
    );
    articleResponse = ArticleResponse.fromJson(
      jsonDecode(
        fixture('get_article_fixture', 'advices'),
      ),
    );
  });

  group('get category list', () {
    test('successfully case', () async {
      when(adviceRemoteDataSource.getCategoryList()).thenAnswer(
        (realInvocation) async => categoryListResponse,
      );
      final result = await adviceRepositoryImpl.getCategoryList(false);

      expect(result, Right(categoryListResponse.toEntity()));

      verify(adviceRemoteDataSource.getCategoryList());

      verify(adviceLocalDataSource.setCategoryList(categoryListResponse));

      verifyNoMoreInteractions(adviceRemoteDataSource);
    });

    test('server error case', () async {
      when(adviceRemoteDataSource.getCategoryList()).thenThrow(
        ServerException(message: 'Something went wrong'),
      );

      final result = await adviceRepositoryImpl.getCategoryList(false);
      expect(
        result,
        Left(ServerFailure(message: 'Something went wrong')),
      );

      verify(adviceRemoteDataSource.getCategoryList());

      verifyNever(adviceLocalDataSource.setCategoryList(categoryListResponse));

      verifyNoMoreInteractions(adviceRemoteDataSource);
    });

    test('should return local object', () async {
      when(adviceLocalDataSource.getCategoryList()).thenAnswer(
        (realInvocation) async => categoryListResponse,
      );
      final result = await adviceRepositoryImpl.getCategoryList(true);
      expect(result, Right(categoryListResponse.toEntity()));
      verify(adviceLocalDataSource.getCategoryList());
      verifyNoMoreInteractions(adviceLocalDataSource);
    });

    test('cache error case', () async {
      when(adviceLocalDataSource.getCategoryList()).thenThrow(
        CacheException(
          message: "Something with cache went wrong!",
        ),
      );
      final result = await adviceRepositoryImpl.getCategoryList(true);
      expect(
          result,
          Left(CacheFailure(
            message: "Something with cache went wrong!",
          )));
      verify(adviceLocalDataSource.getCategoryList());
      verifyNoMoreInteractions(adviceLocalDataSource);
    });
  });

  group('get guid list', () {
    const id = 1233;
    test('successfully case', () async {
      when(adviceRemoteDataSource.getGuidList(id)).thenAnswer(
        (realInvocation) async => guidListResponse,
      );
      final result = await adviceRepositoryImpl.getGuidList(id, false);

      expect(result, Right(guidListResponse.toEntity()));

      verify(adviceRemoteDataSource.getGuidList(id));

      verify(adviceLocalDataSource.setGuidList(guidListResponse, id));

      verifyNoMoreInteractions(adviceRemoteDataSource);
    });

    test('server error case', () async {
      when(adviceRemoteDataSource.getGuidList(id)).thenThrow(
        ServerException(message: 'Something went wrong'),
      );

      final result = await adviceRepositoryImpl.getGuidList(id, false);
      expect(
        result,
        Left(ServerFailure(message: 'Something went wrong')),
      );

      verify(adviceRemoteDataSource.getGuidList(id));

      verifyNever(adviceLocalDataSource.setGuidList(guidListResponse, id));

      verifyNoMoreInteractions(adviceRemoteDataSource);
    });

    test('should return local object', () async {
      when(adviceLocalDataSource.getGuidList(id)).thenAnswer(
        (realInvocation) async => guidListResponse,
      );
      final result = await adviceRepositoryImpl.getGuidList(id, true);
      expect(result, Right(guidListResponse.toEntity()));
      verify(adviceLocalDataSource.getGuidList(id));
      verifyNoMoreInteractions(adviceLocalDataSource);
    });

    test('cache error case', () async {
      when(adviceLocalDataSource.getGuidList(id)).thenThrow(
        CacheException(
          message: "Something with cache went wrong!",
        ),
      );
      final result = await adviceRepositoryImpl.getGuidList(id, true);
      expect(
          result,
          Left(CacheFailure(
            message: "Something with cache went wrong!",
          )));
      verify(adviceLocalDataSource.getGuidList(id));
      verifyNoMoreInteractions(adviceLocalDataSource);
    });
  });

  group('get article', () {});
}
