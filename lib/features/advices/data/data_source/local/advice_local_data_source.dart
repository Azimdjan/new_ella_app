import '../../models/article/article_response.dart';
import '../../models/category_list/category_list_response.dart';
import '../../models/guid_list/guid_list_response.dart';

abstract class AdviceLocalDataSource {
  Future<CategoryListResponse> getCategoryList();

  Future<GuidResponse> getGuidList(String id);

  Future<ArticleResponse> getArticle(String id);
}
