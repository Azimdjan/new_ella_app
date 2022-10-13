part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();
}

class CategoryListTopButtonTapped extends CategoryListEvent {
  final bool showSavedAdvices;

  const CategoryListTopButtonTapped({required this.showSavedAdvices});

  @override
  List<Object?> get props => [showSavedAdvices];
}

class CategoryListCardTapped extends CategoryListEvent {
  final String id;

  const CategoryListCardTapped({required this.id});

  @override
  List<Object?> get props => [id];
}

class CategoryListRefreshed extends CategoryListEvent {
  const CategoryListRefreshed();

  @override
  List<Object?> get props => [];
}
