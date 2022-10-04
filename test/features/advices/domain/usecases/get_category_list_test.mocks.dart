// Mocks generated by Mockito 5.3.2 from annotations
// in ella/test/features/advices/domain/usecases/get_category_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ella/core/error/failure.dart' as _i5;
import 'package:ella/features/advices/domain/entities/article_entity.dart'
    as _i8;
import 'package:ella/features/advices/domain/entities/category_list_entity.dart'
    as _i6;
import 'package:ella/features/advices/domain/entities/guid_list_entity.dart'
    as _i7;
import 'package:ella/features/advices/domain/repository/advices_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AdvicesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdvicesRepository extends _i1.Mock implements _i3.AdvicesRepository {
  MockAdvicesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CategoryListEntity>> getCategoryList(
          bool? isCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCategoryList,
          [isCache],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.CategoryListEntity>>.value(
                _FakeEither_0<_i5.Failure, _i6.CategoryListEntity>(
          this,
          Invocation.method(
            #getCategoryList,
            [isCache],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.CategoryListEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.GuidEntity>> getGuidList(
    String? id,
    bool? isCache,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getGuidList,
          [
            id,
            isCache,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.GuidEntity>>.value(
            _FakeEither_0<_i5.Failure, _i7.GuidEntity>(
          this,
          Invocation.method(
            #getGuidList,
            [
              id,
              isCache,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.GuidEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.ArticleEntity>> getArticle(
    String? id,
    bool? isCache,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getArticle,
          [
            id,
            isCache,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i8.ArticleEntity>>.value(
                _FakeEither_0<_i5.Failure, _i8.ArticleEntity>(
          this,
          Invocation.method(
            #getArticle,
            [
              id,
              isCache,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i8.ArticleEntity>>);
}
