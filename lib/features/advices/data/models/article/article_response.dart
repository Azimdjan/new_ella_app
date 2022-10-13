import 'package:ella/features/advices/domain/entities/article_entity.dart'
    as entity;

class ArticleResponse {
  Article? data;

  ArticleResponse({this.data});

  ArticleResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Article.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Article {
  String? title;
  num? id;
  String? language;
  num? order;
  String? body;

  Article({this.title, this.id, this.language, this.order, this.body});

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    language = json['language'];
    order = json['order'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['language'] = language;
    data['order'] = order;
    data['body'] = body;
    return data;
  }
}

extension ArticleResponseToEntity on ArticleResponse {
  entity.ArticleEntity toEntity() {
    if (data != null) {
      entity.Article? article = data != null
          ? entity.Article(
              data?.title, data?.id, data?.language, data?.order, data?.body)
          : null;
      return entity.ArticleEntity(article);
    } else {
      return const entity.ArticleEntity(null);
    }
  }
}
