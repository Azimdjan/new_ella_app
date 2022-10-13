import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ella/constants/constants.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/features/advices/data/models/category_list/category_list_response.dart';
import 'package:ella/features/advices/domain/entities/category_list_entity.dart';
import 'package:ella/features/advices/domain/usecases/get_category_list.dart';
import 'package:ella/features/advices/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'category_list_bloc_test.mocks.dart';

@GenerateMocks([GetCategoryList])
void main() {
  late final GetCategoryList getCategoryList;
  late final Bloc categoryBloc;
  late final CategoryListEntity categoryListEntity;
  late final CategoryListEntity emptyCategoryListEntity;
  late final CategoryListEntity differentEntity;

  setUpAll(() {
    getCategoryList = MockGetCategoryList();
    categoryBloc = CategoryListBloc(
      getCategoryList: getCategoryList,
    );
    categoryListEntity = CategoryListResponse.fromJson(
            jsonDecode(fixture('get_category_list_fixture_1', 'advices')))
        .toEntity();
    emptyCategoryListEntity = const CategoryListEntity([]);
    differentEntity = CategoryListResponse.fromJson(
        jsonDecode(fixture('get_category_list_fixture_2', 'advices')))
        .toEntity();
  });

  group(
    'test category list',
    () {
      blocTest(
        'successfully from cache and net also successful but different',
        build: () {
          when(getCategoryList.call(const Params(isCache: true))).thenAnswer(
                (realInvocation) async {
              return Right(categoryListEntity);
            },
          );
          when(getCategoryList.call(const Params(isCache: false))).thenAnswer(
                (realInvocation) async {
              return Right(differentEntity);
            },
          );
          return categoryBloc;
        },
        act: (bloc) {
          bloc.add(
            const CategoryListTopButtonTapped(showSavedAdvices: false),
          );
        },
        expect: () => [
          const CategoryListAdvices(status: CategoryStatus.loading),
          CategoryListAdvices(
            status: CategoryStatus.successfull,
            categoryListEntity: categoryListEntity,
          ),
          CategoryListAdvices(
            status: CategoryStatus.successfull,
            categoryListEntity: differentEntity,
          ),
        ],
      );

      blocTest(
        'successfully from cache and net also successful',
        build: () {
          when(getCategoryList.call(const Params(isCache: true))).thenAnswer(
            (realInvocation) async {
              return Right(categoryListEntity);
            },
          );
          when(getCategoryList.call(const Params(isCache: false))).thenAnswer(
            (realInvocation) async {
              return Right(categoryListEntity);
            },
          );
          return categoryBloc;
        },
        act: (bloc) {
          bloc.add(
            const CategoryListTopButtonTapped(showSavedAdvices: false),
          );
        },
        expect: () => [
          const CategoryListAdvices(status: CategoryStatus.loading),
          CategoryListAdvices(
            status: CategoryStatus.successfull,
            categoryListEntity: categoryListEntity,
          ),
        ],
      );

      blocTest(
        'successfully from cache and net error',
        build: () {
          when(getCategoryList.call(const Params(isCache: true))).thenAnswer(
            (realInvocation) async {
              return Right(categoryListEntity);
            },
          );
          when(getCategoryList.call(const Params(isCache: false))).thenAnswer(
            (realInvocation) async {
              return Left(ServerFailure(
                message: Validations.SOMETHING_WENT_WRONG,
              ));
            },
          );
          return categoryBloc;
        },
        act: (bloc) {
          bloc.add(
            const CategoryListTopButtonTapped(showSavedAdvices: false),
          );
        },
        expect: () => [
          const CategoryListAdvices(status: CategoryStatus.loading),
          CategoryListAdvices(
            status: CategoryStatus.successfull,
            categoryListEntity: categoryListEntity,
          ),
          CategoryListAdvices(
            status: CategoryStatus.error,
            categoryListEntity: categoryListEntity,
            errorMessage: Validations.SOMETHING_WENT_WRONG,
          ),
        ],
      );

      blocTest(
        'error from cache then net successfull',
        build: () {
          when(getCategoryList.call(const Params(isCache: true))).thenAnswer(
            (realInvocation) async => Left(
              CacheFailure(
                message: Validations.SOMETHING_WENT_WRONG,
              ),
            ),
          );
          when(getCategoryList.call(const Params(isCache: false))).thenAnswer(
            (realInvocation) async => Right(
              categoryListEntity,
            ),
          );
          return categoryBloc;
        },
        act: (bloc) {
          bloc.add(
            const CategoryListTopButtonTapped(showSavedAdvices: false),
          );
        },
        expect: () => <CategoryListState>[
          const CategoryListAdvices(status: CategoryStatus.loading),
          CategoryListAdvices(
            status: CategoryStatus.successfull,
            categoryListEntity: categoryListEntity,
          ),
        ],
      );

      blocTest(
        'error from cache then net also error',
        build: () {
          when(getCategoryList.call(const Params(isCache: true))).thenAnswer(
            (realInvocation) async => Left(
              CacheFailure(
                message: Validations.SOMETHING_WENT_WRONG,
              ),
            ),
          );
          when(getCategoryList.call(const Params(isCache: false))).thenAnswer(
            (realInvocation) async => Left(
              ServerFailure(
                message: Validations.SOMETHING_WENT_WRONG,
              ),
            ),
          );
          return categoryBloc;
        },
        act: (bloc) {
          bloc.add(
            const CategoryListTopButtonTapped(showSavedAdvices: false),
          );
        },
        expect: () => [
          const CategoryListAdvices(status: CategoryStatus.loading),
          const CategoryListAdvices(
            status: CategoryStatus.error,
            errorMessage: Validations.SOMETHING_WENT_WRONG,
          ),
        ],
      );

      blocTest(
        'empty case',
        build: () {
          when(getCategoryList.call(const Params(isCache: true))).thenAnswer(
            (realInvocation) async => Left(
              CacheFailure(
                message: Validations.SOMETHING_WENT_WRONG,
              ),
            ),
          );
          when(getCategoryList.call(const Params(isCache: false))).thenAnswer(
            (realInvocation) async => Right(
              emptyCategoryListEntity,
            ),
          );
          return categoryBloc;
        },
        act: (bloc) {
          bloc.add(
            const CategoryListTopButtonTapped(showSavedAdvices: false),
          );
        },
        expect: () => [
          const CategoryListAdvices(status: CategoryStatus.loading),
          CategoryListAdvices(
            status: CategoryStatus.empty,
            categoryListEntity: emptyCategoryListEntity,
          ),
        ],
      );
    },
  );
}
