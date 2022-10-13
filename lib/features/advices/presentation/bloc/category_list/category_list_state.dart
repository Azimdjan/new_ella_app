part of 'category_list_bloc.dart';

abstract class CategoryListState extends Equatable {
  const CategoryListState();
}

class CategoryListInitial extends CategoryListState {
  @override
  List<Object> get props => [];
}

class CategoryListAdvices extends CategoryListState {
  final CategoryStatus status;
  final CategoryListEntity? categoryListEntity;
  final String? errorMessage;

  const CategoryListAdvices({
    required this.status,
    this.categoryListEntity,
    this.errorMessage,
  });

  CategoryListAdvices copyWith({
    CategoryStatus? status,
    CategoryListEntity? categoryListEntity,
    String? errorMessage,
  }) {
    return CategoryListAdvices(
      status: status ?? this.status,
      categoryListEntity: categoryListEntity ?? this.categoryListEntity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categoryListEntity,
        errorMessage,
      ];
}

class CategoryListSavedAdvices extends CategoryListState {
  final CategoryStatus status;
  final CategoryListEntity? categoryListEntity;
  final String? errorMessage;

  const CategoryListSavedAdvices({
    required this.status,
    this.categoryListEntity,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        status,
        categoryListEntity,
        errorMessage,
      ];
}

enum CategoryStatus {
  loading,
  error,
  empty,
  successfull,
}

extension CategoryStatusX on CategoryStatus {
  bool isLoading() {
    return this == CategoryStatus.loading;
  }

  bool isError() {
    return this == CategoryStatus.error;
  }

  bool isEmpty() {
    return this == CategoryStatus.empty;
  }

  bool isSuccessfull() {
    return this == CategoryStatus.successfull;
  }
}
