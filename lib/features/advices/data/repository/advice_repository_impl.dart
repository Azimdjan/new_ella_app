import 'package:dartz/dartz.dart';
import 'package:ella/core/error/exceptions.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/platform/network_info.dart';
import 'package:ella/features/advices/data/data_source/local/advice_local_data_source.dart';
import 'package:ella/features/advices/data/data_source/remote/advice_remote_data_source.dart';
import 'package:ella/features/advices/data/models/article/article_response.dart';
import 'package:ella/features/advices/data/models/category_list/category_list_response.dart';
import 'package:ella/features/advices/data/models/guid_list/guid_list_response.dart';
import 'package:ella/features/advices/domain/entities/article_entity.dart';
import 'package:ella/features/advices/domain/entities/category_list_entity.dart';
import 'package:ella/features/advices/domain/entities/guid_list_entity.dart';
import 'package:ella/features/advices/domain/repository/advices_repository.dart';

class AdviceRepositoryImpl implements AdvicesRepository {
  final AdviceRemoteDataSource adviceRemoteDataSource;
  final AdviceLocalDataSource adviceLocalDataSource;
  final NetworkInfo networkInfo;

  AdviceRepositoryImpl({
    required this.adviceRemoteDataSource,
    required this.adviceLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ArticleEntity>> getArticle(
      String id, bool isCache) async {
    if (!isCache) {
      try {
        final response = await adviceRemoteDataSource.getArticle(id);
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          ServerFailure(
              message:
                  (e is ServerException) ? e.message : 'Something went wrong!'),
        );
      }
    } else {
      try {
        final response = await adviceLocalDataSource.getArticle(id);
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          CacheFailure(
              message:
                  (e is CacheException) ? e.message : 'Something went wrong!'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, CategoryListEntity>> getCategoryList(
      bool isCache) async {
    if (!isCache) {
      try {
        final response = await adviceRemoteDataSource.getCategoryList();
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          ServerFailure(
              message:
                  (e is ServerException) ? e.message : 'Something went wrong!'),
        );
      }
    } else {
      try {
        final response = await adviceLocalDataSource.getCategoryList();
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          CacheFailure(
              message:
                  (e is CacheException) ? e.message : 'Something went wrong!'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, GuidEntity>> getGuidList(
      String id, bool isCache) async {
    if (!isCache) {
      try {
        final response = await adviceRemoteDataSource.getGuidList(id);
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          ServerFailure(
              message:
                  (e is ServerException) ? e.message : 'Something went wrong!'),
        );
      }
    } else {
      try {
        final response = await adviceLocalDataSource.getGuidList(id);
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          CacheFailure(
              message:
                  (e is CacheException) ? e.message : 'Something went wrong!'),
        );
      }
    }
  }
}
