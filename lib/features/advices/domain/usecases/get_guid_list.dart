import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/core/usecase/usecase.dart';
import 'package:ella/features/advices/domain/entities/guid_list_entity.dart';
import 'package:ella/features/advices/domain/repository/advices_repository.dart';

class GetGuidList extends UseCase<GuidEntity, Params> {
  final AdvicesRepository advicesRepository;

  GetGuidList(this.advicesRepository);

  @override
  Future<Either<Failure, GuidEntity>> call(Params params) async {
    return await advicesRepository.getGuidList(params.id, params.isCache);
  }
}

class Params {
  final String id;
  final bool isCache;

  Params(this.id, {this.isCache = false});
}
