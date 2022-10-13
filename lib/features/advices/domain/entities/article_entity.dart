import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final Article? data;

  const ArticleEntity(this.data);

  @override
  List<Object?> get props => [data];
}

class Article extends Equatable {
  final String? title;
  final num? id;
  final String? language;
  final num? order;
  final String? body;

  const Article(this.title, this.id, this.language, this.order, this.body);

  @override
  List<Object?> get props => [title, id, language, order, body];
}
