import 'package:dio/dio.dart';
import 'package:ella/constants/constants.dart';
import 'package:ella/features/advices/data/data_source/remote/advice_remote_data_source.dart';
import 'package:ella/features/advices/data/models/article/article_response.dart';
import 'package:ella/features/advices/data/models/category_list/category_list_response.dart';
import 'package:ella/features/advices/data/models/guid_list/guid_list_response.dart';

import '../../../../../core/error/exceptions.dart';

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final Dio dio;

  AdviceRemoteDataSourceImpl(this.dio);

  final options = Options(
    contentType: 'application/json',
    headers: {},
    receiveTimeout: 30000,
    sendTimeout: 30000,
  );

  @override
  Future<ArticleResponse> getArticle(num id) async {
    final response = await dio.get(
      Constants.baseUrl + Urls.GET_ARTICLE_URL,
      options: options.copyWith(
        headers: {
          'id': id,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ArticleResponse.fromJson(response.data);
    } else {
      throw ServerException(message: response.data);
    }
  }

  @override
  Future<CategoryListResponse> getCategoryList() async {
    final response = await dio.get(
      Constants.baseUrl + Urls.GET_CATEGORY_LIST_URL,
      options: options,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CategoryListResponse.fromJson(response.data);
    } else {
      throw ServerException(message: response.data);
    }
  }

  @override
  Future<GuidResponse> getGuidList(num id) async {
    final response = await dio.get(
      Constants.baseUrl + Urls.GET_GUID_LIST_URL,
      options: options.copyWith(
        headers: {
          'id': id,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return GuidResponse.fromJson(response.data);
    } else {
      throw ServerException(
        message: response.data,
      );
    }
  }
}
