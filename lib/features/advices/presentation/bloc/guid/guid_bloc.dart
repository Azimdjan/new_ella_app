import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ella/constants/constants.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/features/advices/domain/entities/guid_list_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_guid_list.dart';

part 'guid_event.dart';

part 'guid_state.dart';

class GuidBloc extends Bloc<GuidEvent, GuidState> {
  final GetGuidList getGuidList;

  GuidBloc(this.getGuidList)
      : super(
          const GuidState(
            status: GuidStatus.initial,
            isSaved: false,
          ),
        ) {
    on<GuidLoad>(_loadHandler);
    on<GuidRefresh>(_refreshHandler);
    on<GuidSave>(_saveHandler);
  }

  void _loadHandler(GuidLoad event, Emitter<GuidState> emit) async {
    emit(
      state.copyWith(
        status: GuidStatus.loading,
      ),
    );
    GuidEntity? guidEntity = await getCachedGuid(emit, event.id);
    await getNetworkGuid(emit, event.id, guidEntity);
  }

  Future<GuidEntity?> getCachedGuid(Emitter<GuidState> emit, num id) async {
    final response = await getGuidList(
      Params(id, isCache: true),
    );
    return response.fold(
      (error) {
        print('No data');
        // emit(
        //   state.copyWith(
        //     status: GuidStatus.error,
        //     errorMessage: (error is CacheFailure)
        //         ? error.message
        //         : Validations.SOMETHING_WENT_WRONG,
        //   ),
        // );
        return null;
      },
      (success) {
        emit(
          state.copyWith(
            status: GuidStatus.success,
            guidList: success,
          ),
        );
        return success;
      },
    );
  }

  Future<void> getNetworkGuid(Emitter<GuidState> emit, num id,
      [GuidEntity? cachedGuid]) async {
    final response = await getGuidList(
      Params(id, isCache: false),
    );
    response.fold(
      (error) {
        emit(
          state.copyWith(
            status: GuidStatus.error,
            errorMessage: (error is ServerFailure)
                ? error.message
                : Validations.SOMETHING_WENT_WRONG,
          ),
        );
      },
      (success) {
        if (cachedGuid != success) {
          emit(
            state.copyWith(
              status: GuidStatus.success,
              guidList: success,
            ),
          );
        }
      },
    );
  }

  Future<void> _refreshHandler(
      GuidRefresh event, Emitter<GuidState> emit) async {
    await getNetworkGuid(emit, event.id);
  }

  void _saveHandler(GuidSave event, Emitter<GuidState> emit) {
    emit(state.copyWith(isSaved: !state.isSaved));
  }
}
