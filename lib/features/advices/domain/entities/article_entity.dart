class ArticleEntity {
  final Article? data;

  ArticleEntity(this.data);
}

class Article {
  final String? title;
  final num? id;
  final String? language;
  final num? order;
  final String? body;

  Article(this.title, this.id, this.language, this.order, this.body);
}
