import 'package:ella/features/advices/data/models/category_list/category_list_response.dart';
import 'package:ella/features/advices/data/models/guid_list/guid_list_response.dart';

import '../../models/article/article_response.dart';

abstract class AdviceRemoteDataSource {
  Future<CategoryListResponse> getCategoryList();

  Future<GuidResponse> getGuidList(String id);

  Future<ArticleResponse> getArticle(String id);
}
