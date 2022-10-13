import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/usecase/usecase.dart';
import 'package:ella/features/advices/domain/repository/advices_repository.dart';
import 'package:equatable/equatable.dart';

import '../entities/category_list_entity.dart';

class GetCategoryList extends UseCase<CategoryListEntity, Params> {
  final AdvicesRepository advicesRepository;

  GetCategoryList(this.advicesRepository);

  @override
  Future<Either<Failure, CategoryListEntity>> call([Params? params]) async {
    return await advicesRepository.getCategoryList(params?.isCache ?? false);
  }
}

class Params extends Equatable {
  final bool isCache;

  const Params({this.isCache = false});

  @override
  List<Object?> get props => [isCache];
}
