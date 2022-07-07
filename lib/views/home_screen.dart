import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/newsbloc/news_bloc.dart';
import 'package:weatherapp/blocs/newsbloc/news_state.dart';
import 'package:weatherapp/models/article_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.03),
                child: Text(
                  "Bloc News API".toUpperCase(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.7),
                width: width,
                margin: EdgeInsets.symmetric(horizontal: width * 0.01),
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: height * 0.08),
          child: BlocBuilder<NewsBloc, NewsStates>(
            builder: (BuildContext context, NewsStates state) {
              if (state is NewsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsLoadedState) {
                List<ArticleModel> _articleList = [];
                _articleList = state.articleList;
                return ListView.builder(
                    itemCount: _articleList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  spreadRadius: 1)
                            ]),
                        height: height * 0.15,
                        margin: EdgeInsets.only(
                            bottom: height * 0.01,
                            top: height * 0.01,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.3,
                              height: height * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        _articleList[index].urlToImage != null
                                            ? _articleList[index].urlToImage ??
                                                ""
                                            : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Container(
                              height: height * 0.15,
                              width: width * 0.55,
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Column(
                                children: [
                                  Text(
                                    _articleList[index].description ?? "",
                                    style: TextStyle(
                                      overflow: TextOverflow.clip,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else if (state is NewsErrorState) {
                String error = state.errorMessage;
                return Center(
                  child: Text(error),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      ],
    )));
  }
}
