import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp/models/article_model.dart';
import 'package:flutter/foundation.dart';
class NewsStates extends Equatable{
  const NewsStates();

  @override
  List<Object> get props =>[];
}

class NewsInitState extends NewsStates{}

class NewsLoadingState extends NewsStates{}

class NewsLoadedState extends NewsStates{
  final List<ArticleModel> articleList;
  NewsLoadedState({required this.articleList});
}

class NewsErrorState extends NewsStates{
  final  errorMessage;
  NewsErrorState({required this.errorMessage});

}