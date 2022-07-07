import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/article_model.dart';

class NewsRepository{
  Future<List<ArticleModel>> fetchNews() async{
    var response= await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=us&apiKey=3a8987862df244e58f429b0f7fd21a95"));

    var data= jsonDecode(response.body);

List<ArticleModel> _articleModelList=[];

if(response.statusCode==200){
  for(var item in data["articles"]){
    ArticleModel _artcileModel= ArticleModel.fromJson(item);
    _articleModelList.add(_artcileModel);
  }
  return _articleModelList;
}else{
  return _articleModelList;
}
    
  }
}