import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/services/news_service.dart';

import 'package:news_app/src/widgets/list_news.dart';

class Tab1Screen extends StatefulWidget {
  @override
  _Tab1ScreenState createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.length == 0)
          ? Center(child: CircularProgressIndicator())
          : ListNews(newsService.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
