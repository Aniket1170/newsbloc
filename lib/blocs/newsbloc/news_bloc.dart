import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/newsbloc/news_events.dart';
import 'package:weatherapp/blocs/newsbloc/news_state.dart';
import 'package:weatherapp/models/article_model.dart';
import 'package:weatherapp/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepository newsRepository;
  NewsBloc({required NewsStates initialState, required this.newsRepository})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsStates> mapEventsToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<ArticleModel> _articleList = [];
        yield NewsLoadingState();
        _articleList = await newsRepository.fetchNews();
        yield NewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewsErrorState(errorMessage: e);
      }
    }
  }
}
//bloc completed
