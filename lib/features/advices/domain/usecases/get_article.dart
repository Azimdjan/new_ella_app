import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/usecase/usecase.dart';
import 'package:ella/features/advices/domain/repository/advices_repository.dart';

import '../entities/article_entity.dart';

class GetArticle extends UseCase<ArticleEntity, Params> {
  final AdvicesRepository advicesRepository;

  GetArticle(this.advicesRepository);

  @override
  Future<Either<Failure, ArticleEntity>> call(Params params) async {
    return await advicesRepository.getArticle(params.id, params.isCache);
  }
}

class Params {
  final num id;
  final bool isCache;

  Params(this.id, {this.isCache = false});
}
