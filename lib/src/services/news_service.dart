import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/models/category_models.dart';

const _URL_NEWS = 'https://newsapi.org/v2';
const _API_KEY = '683e3711f1684b54b2ec4316e761baf5';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  String _selectedCategory = 'business';
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach(
      (element) {
        this.categoryArticles[element.name] = [];
      },
    );
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticleByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticlesCartegorySelected =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=co';

    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticleByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=co&category=$category';

    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
