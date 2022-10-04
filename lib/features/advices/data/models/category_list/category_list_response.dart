import 'package:ella/features/advices/domain/entities/category_list_entity.dart';

class CategoryListResponse {
  List<CategoryResponse>? data;

  CategoryListResponse({this.data});

  CategoryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryResponse>[];
      json['data'].forEach((v) {
        data!.add(CategoryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryResponse {
  String? name;
  num? id;
  String? language;
  List<GuideResponse>? guides;

  CategoryResponse({this.name, this.id, this.language, this.guides});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    language = json['language'];
    if (json['guides'] != null) {
      guides = <GuideResponse>[];
      json['guides'].forEach((v) {
        guides!.add(GuideResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['language'] = language;
    if (guides != null) {
      data['guides'] = guides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GuideResponse {
  num? id;
  String? name;
  String? language;

  GuideResponse({this.id, this.name, this.language});

  GuideResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['language'] = language;
    return data;
  }
}

extension CategoryListResponseToEntity on CategoryListResponse {
  CategoryListEntity toEntity() {
    if (data != null) {
      final categories = data?.map(
        (category) {
          final guides = category.guides
              ?.map((guid) => Guid(guid.name, guid.id, guid.language))
              .toList();
          return Category(
            category.name,
            category.id,
            category.language,
            guides,
          );
        },
      ).toList();
      return CategoryListEntity(categories);
    } else {
      return CategoryListEntity(null);
    }
  }
}
