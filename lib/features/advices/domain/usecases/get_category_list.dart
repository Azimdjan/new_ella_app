import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/usecase/usecase.dart';
import 'package:ella/features/advices/domain/repository/advices_repository.dart';

import '../entities/category_list_entity.dart';

class GetCategoryList extends UseCase<CategoryListEntity, Params> {
  final AdvicesRepository advicesRepository;

  GetCategoryList(this.advicesRepository);

  @override
  Future<Either<Failure, CategoryListEntity>> call(Params params) async {
    return await advicesRepository.getCategoryList(params.isCache);
  }
}

class Params {
  final bool isCache;

  Params({this.isCache = false});
}
