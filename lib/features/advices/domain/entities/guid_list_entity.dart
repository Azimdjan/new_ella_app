import 'package:equatable/equatable.dart';

class GuidEntity extends Equatable {
  final Guid? data;

  const GuidEntity(this.data);

  @override
  List<Object?> get props => [data];
}

class Guid extends Equatable {
  final num? id;
  final String? name;
  final String? language;
  final List<Article>? articles;

  const Guid(this.id, this.name, this.language, this.articles);

  @override
  List<Object?> get props => [id, name, language, articles];
}

class Article extends Equatable {
  final String? title;
  final num? id;
  final String? language;

  const Article(this.title, this.id, this.language);

  @override
  List<Object?> get props => [title, id, language];
}
