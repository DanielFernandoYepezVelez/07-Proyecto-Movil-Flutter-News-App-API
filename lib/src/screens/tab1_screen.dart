import 'package:flutter/material.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/services/news_service.dart';

class Tab1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: ListNews(newsService.headlines),
    );
  }
}
