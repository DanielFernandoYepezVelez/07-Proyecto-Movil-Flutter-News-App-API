import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/src/models/news_models.dart';

const _URL_NEWS = 'https://newsapi.org/v2';
const _API_KEY = '683e3711f1684b54b2ec4316e761baf5';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=co';

    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
