import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/features/advices/domain/entities/article_entity.dart';
import 'package:ella/features/advices/domain/entities/category_list_entity.dart';
import 'package:ella/features/advices/domain/entities/guid_list_entity.dart';

abstract class AdvicesRepository {
  Future<Either<Failure, CategoryListEntity>> getCategoryList(bool isCache);

  Future<Either<Failure, GuidEntity>> getGuidList(String id, bool isCache);

  Future<Either<Failure, ArticleEntity>> getArticle(String id, bool isCache);
}
