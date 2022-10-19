import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_article.dart';

part 'article_event.dart';

part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticle getArticle;

  ArticleBloc(this.getArticle) : super(ArticleInitial()) {
    on<ArticleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
