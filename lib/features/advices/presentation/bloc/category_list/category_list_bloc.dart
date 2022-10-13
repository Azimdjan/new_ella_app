import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ella/core/error/failure.dart';
import 'package:ella/features/advices/domain/entities/category_list_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../domain/usecases/get_category_list.dart';

part 'category_list_event.dart';

part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final GetCategoryList getCategoryList;

  CategoryListBloc({
    required this.getCategoryList,
  }) : super(CategoryListInitial()) {
    on<CategoryListTopButtonTapped>(_topButtonTappedHandler);
    on<CategoryListCardTapped>(_cardTapped);
    on<CategoryListRefreshed>(_refreshed);
  }

  ///To toggle advice page
  void _topButtonTappedHandler(CategoryListTopButtonTapped event,
      Emitter<CategoryListState> emit) async {
    if (event.showSavedAdvices) {
      await showSavedAdvices(emit);
    } else {
      await showAdviceMethod(emit);
    }
  }

  //for showing advices
  Future<void> showAdviceMethod(Emitter<CategoryListState> emit) async {
    emit(
      const CategoryListAdvices(status: CategoryStatus.loading),
    );
    CategoryListEntity? categoryListEntityCached =
        await getCategoryListAdviceMethod(
      emit,
      isCached: true,
    );
    await getCategoryListAdviceMethod(
      emit,
      categoryListEntityCached: categoryListEntityCached,
      isCached: false,
    );
  }

  Future<CategoryListEntity?> getCategoryListAdviceMethod(
      Emitter<CategoryListState> emit,
      {bool isCached = false,
      CategoryListEntity? categoryListEntityCached}) async {
    final categoryListEntity = await getCategoryList(
      Params(isCache: isCached),
    );
    if (isCached) {
      categoryFromCache(categoryListEntity, emit);
    } else if (categoryListEntityCached != null) {
      categoryComparison(categoryListEntity, emit, categoryListEntityCached);
    } else {
      categoryFirstTime(categoryListEntity, emit);
    }
    return categoryListEntity.fold((error) => null, (success) => success);
  }

  void categoryFirstTime(Either<Failure, CategoryListEntity> categoryListEntity,
      Emitter<CategoryListState> emit) {
    categoryListEntity.fold(
      (error) {
        emit(
          CategoryListAdvices(
            status: CategoryStatus.error,
            errorMessage: (error is CacheFailure)
                ? error.message
                : Validations.SOMETHING_WENT_WRONG,
          ),
        );
      },
      (success) {
        if ((success.data ?? []).isNotEmpty) {
          emit(
            CategoryListAdvices(
              status: CategoryStatus.successfull,
              categoryListEntity: success,
            ),
          );
        } else {
          emit(
            CategoryListAdvices(
              status: CategoryStatus.empty,
              categoryListEntity: success,
            ),
          );
        }
      },
    );
  }

  void categoryComparison(
    Either<Failure, CategoryListEntity> categoryListEntity,
    Emitter<CategoryListState> emit,
    CategoryListEntity categoryListEntityCached,
  ) {
    categoryListEntity.fold(
      (error) {
        emit(
          CategoryListAdvices(
            status: CategoryStatus.error,
            categoryListEntity: categoryListEntityCached,
            errorMessage: (error is CacheFailure)
                ? error.message
                : Validations.SOMETHING_WENT_WRONG,
          ),
        );
      },
      (success) {
        if ((success.data ?? []).isNotEmpty) {
          if (success != categoryListEntityCached) {
            emit(
              CategoryListAdvices(
                status: CategoryStatus.successfull,
                categoryListEntity: success,
              ),
            );
          }
        } else {
          emit(
            CategoryListAdvices(
              status: CategoryStatus.empty,
              categoryListEntity: success,
            ),
          );
        }
      },
    );
  }

  void categoryFromCache(
    Either<Failure, CategoryListEntity> categoryListEntity,
    Emitter<CategoryListState> emit,
  ) {
    categoryListEntity.fold(
      (error) {
        ///Need to think what can we do here
        // emit(
        //   CategoryListAdvices(
        //     status: CategoryStatus.error,
        //     categoryListEntity: categoryListEntityCached,
        //     errorMessage: (error is CacheFailure)
        //         ? error.message
        //         : Validations.SOMETHING_WENT_WRONG,
        //   ),
        // );
      },
      (success) {
        if ((success.data ?? []).isNotEmpty) {
          emit(
            CategoryListAdvices(
              status: CategoryStatus.successfull,
              categoryListEntity: success,
            ),
          );
        }
      },
    );
  }

  //for showing saved advices
  Future<void> showSavedAdvices(Emitter<CategoryListState> emit) async {}

  ///To go guid page
  void _cardTapped(
      CategoryListCardTapped event, Emitter<CategoryListState> emit) {}

  ///For refreshing advice page
  void _refreshed(
      CategoryListRefreshed event, Emitter<CategoryListState> emit) {}
}
