import 'package:flutter/material.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/models/category_models.dart';

import 'package:news_app/src/theme/tema.dart';

class Tab2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: _ListCategory()),
          Expanded(child: ListNews(newsService.getArticlesCartegorySelected))
        ],
      ),
    );
  }
}

class _ListCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          /* Capitalizando El Titulo De La Categoria */
          final cName = categories[index].name;

          return Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryBotton(categories[index]),
                  SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryBotton extends StatelessWidget {
  final Category category;

  const _CategoryBotton(this.category);

  @override
  Widget build(BuildContext context) {
    /* Aqui El Provider Se Tiene Que Redibujar */
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        /* Cuando Estoy En Un Tap O Click El Provider No Se Tiene Que Redibujar (listen: False)*/
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? tema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
