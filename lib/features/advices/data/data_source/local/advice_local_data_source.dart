import '../../models/article/article_response.dart';
import '../../models/category_list/category_list_response.dart';
import '../../models/guid_list/guid_list_response.dart';

abstract class AdviceLocalDataSource {
  Future<CategoryListResponse> getCategoryList();

  Future<GuidResponse> getGuidList(num id);

  Future<ArticleResponse> getArticle(num id);

  Future<void> setCategoryList(CategoryListResponse categoryListResponse);

  Future<void> setGuidList(GuidResponse guidResponse, num id);

  Future<void> setArticle(ArticleResponse articleResponse, num id);
}
