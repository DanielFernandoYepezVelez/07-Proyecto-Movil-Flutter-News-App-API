import 'package:flutter/material.dart';

/* Models */
import 'package:news_app/src/models/news_models.dart';

/* Thema */
import 'package:news_app/src/theme/tema.dart';

class ListNews extends StatelessWidget {
  final List<Article>? noticias;

  const ListNews(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias!.length,
      itemBuilder: (_, int index) {
        return _New(noticia: this.noticias![index], index: index);
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
        _TarjetaBody(this.noticia),
        _TarjetaBottons(),
        SizedBox(height: 10),
        Divider(),
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
          Text('${this.noticia.source.name}.')
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
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        child: Container(
          // ignore: unnecessary_null_comparison
          child: (this.noticia.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(this.noticia.urlToImage),
                )
              : Image(
                  image: AssetImage('assets/img/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Text(
          // ignore: unnecessary_null_comparison
          (this.noticia.description != null) ? this.noticia.description : ''),
    );
  }
}

class _TarjetaBottons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: tema.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}
