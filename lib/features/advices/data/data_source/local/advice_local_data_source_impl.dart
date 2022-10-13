import 'dart:convert';

import 'package:ella/constants/constants.dart';
import 'package:ella/core/error/exceptions.dart';
import 'package:ella/features/advices/data/data_source/local/advice_local_data_source.dart';
import 'package:ella/features/advices/data/models/article/article_response.dart';
import 'package:ella/features/advices/data/models/category_list/category_list_response.dart';
import 'package:ella/features/advices/data/models/guid_list/guid_list_response.dart';
import 'package:hive/hive.dart';

const errorMessage = "No such data in Database";
const misMatchingId = "Ids do not match";

class AdviceLocalDataSourceImpl implements AdviceLocalDataSource {
  final Box<dynamic> box;

  const AdviceLocalDataSourceImpl(this.box);

  @override
  Future<ArticleResponse> getArticle(num id) async {
    final articleJson = await box.get(
      DatabaseKeys.ARTICLE + id.toString(),
      defaultValue: null,
    );
    if (articleJson != null) {
      final article = ArticleResponse.fromJson(jsonDecode(articleJson));
      if(article.data?.id == id) {
        return article;
      } else {
        throw CacheException(message: misMatchingId);
      }
    } else {
      throw CacheException(message: errorMessage);
    }
  }

  @override
  Future<CategoryListResponse> getCategoryList() async {
    final categoryList = await box.get(
      DatabaseKeys.CATEGORY_LIST,
      defaultValue: null,
    );
    if (categoryList != null) {
      return CategoryListResponse.fromJson(jsonDecode(categoryList));
    } else {
      throw CacheException(message: errorMessage);
    }
  }

  @override
  Future<GuidResponse> getGuidList(num id) async {
    final guidList = await box.get(
      DatabaseKeys.GUID_LIST + id.toString(),
      defaultValue: null,
    );
    if (guidList != null) {
      return GuidResponse.fromJson(jsonDecode(guidList));
    } else {
      throw CacheException(message: errorMessage);
    }
  }

  @override
  Future<void> setArticle(ArticleResponse articleResponse, num id) async {
    final articleJson = jsonEncode(articleResponse.toJson());
    await box.put(DatabaseKeys.ARTICLE, articleJson);
  }

  @override
  Future<void> setCategoryList(
      CategoryListResponse categoryListResponse) async {
    final categoryListJson = jsonEncode(categoryListResponse.toJson());
    await box.put(DatabaseKeys.CATEGORY_LIST, categoryListJson);
  }

  @override
  Future<void> setGuidList(GuidResponse guidResponse, num id) async {
    final guidJson = jsonEncode(guidResponse.toJson());
    await box.put(DatabaseKeys.GUID_LIST, guidJson);
  }
}
