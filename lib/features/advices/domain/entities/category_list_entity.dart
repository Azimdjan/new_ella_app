import 'package:equatable/equatable.dart';

class CategoryListEntity extends Equatable {
  final List<Category>? data;

  const CategoryListEntity(this.data);

  @override
  List<Object?> get props => [data];
}

class Category extends Equatable {
  final String? name;
  final num? id;
  final String? language;
  final List<Guid>? guides;

  const Category(this.name, this.id, this.language, this.guides);

  @override
  List<Object?> get props => [name, id, language, guides];
}

class Guid extends Equatable {
  final String? name;
  final num? id;
  final String? language;

  const Guid(this.name, this.id, this.language);

  @override
  List<Object?> get props => [name, id, language];
}
