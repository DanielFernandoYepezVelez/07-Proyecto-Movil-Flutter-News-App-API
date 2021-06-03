import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/tema.dart';

class ListNews extends StatelessWidget {
  final List<Article> noticias;

  const ListNews(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (_, int index) {
        return _New(noticia: this.noticias[index], index: index);
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article noticia;
  final int index;

  const _New({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(this.noticia, this.index),
        _TarjetaTitle(this.noticia),
        _TarjetaImage(this.noticia),
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(color: tema.accentColor),
          ),
          Text('${noticia.source.name}.')
        ],
      ),
    );
  }
}

class _TarjetaTitle extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitle(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaImage extends StatelessWidget {
  final Article noticia;

  const _TarjetaImage(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hola Mundo'),
    );
  }
}
