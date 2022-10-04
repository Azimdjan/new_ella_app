import 'package:ella/features/advices/domain/entities/guid_list_entity.dart'
    as entity;

class GuidResponse {
  Guid? data;

  GuidResponse({this.data});

  GuidResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Guid.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Guid {
  num? id;
  String? name;
  String? language;
  List<Article>? articles;

  Guid({this.id, this.name, this.language, this.articles});

  Guid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    language = json['language'];
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((v) {
        articles!.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['language'] = language;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article {
  String? title;
  num? id;
  String? language;

  Article({this.title, this.id, this.language});

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['language'] = language;
    return data;
  }
}

extension GuidResponseToEntity on GuidResponse {
  entity.GuidEntity toEntity() {
    if (data != null) {
      final articles = data?.articles
          ?.map(
            (article) =>
                entity.Article(article.title, article.id, article.language),
          )
          .toList();
      final guid = entity.Guid(data?.id, data?.name, data?.language, articles);
      return entity.GuidEntity(guid);
    } else {
      return entity.GuidEntity(null);
    }
  }
}
