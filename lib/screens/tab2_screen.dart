import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/* Services */
import 'package:news_api_flutter/services/news_service.dart';

/* Models */
import 'package:news_api_flutter/models/category_models.dart';

/* Widgets */
import 'package:news_api_flutter/widgets/list_news.dart';

/* Tema Application */
import 'package:news_api_flutter/theme/tema.dart';

class Tab2Screen extends StatefulWidget {
  @override
  State<Tab2Screen> createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen> {
  NativeAd? _nativeVideoAd;
  bool _isLoadedVideoNative = false;

  @override
  void initState() {
    super.initState();
    _loadVideoNativeAd();
  }

  void _loadVideoNativeAd() {
    _nativeVideoAd = NativeAd(
      // adUnitId: 'ca-app-pub-3940256099942544/1044960115',
      adUnitId: 'ca-app-pub-8702651755109746/7805058932',
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(onAdLoaded: (ad) {
        /* print('Video Ad Loaded Successfully'); */
        setState(() {
          _isLoadedVideoNative = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        /* print(
            'Actually Ad Video Failed To Load ${error.message}, ${error.code}'); */
        ad.dispose();
      }),
    );

    _nativeVideoAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 295,
                  child: !_isLoadedVideoNative
                      ? FadeInImage(
                          placeholder: AssetImage('assets/img/giphy.gif'),
                          image: AssetImage('assets/img/giphy.gif'),
                        )
                      : AdWidget(ad: _nativeVideoAd!),
                ),
                // SizedBox(height: 5),
                _ListCategory(),
              ],
            ),
          ),
          Expanded(
            child: ListNews(newsService.getArticlesCartegorySelected),
          )
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
      height: 78,
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

class _CategoryBotton extends StatefulWidget {
  final Category category;

  const _CategoryBotton(this.category);

  @override
  State<_CategoryBotton> createState() => _CategoryBottonState();
}

class _CategoryBottonState extends State<_CategoryBotton> {
  InterstitialAd? _interstitialVideoAd;
  bool _isLoadedInterstitialVideo = false;

  InterstitialAd? _interstitialVideoAd2;
  bool _isLoadedInterstitialVideo2 = false;

  @override
  void initState() {
    super.initState();
    _loadInterstitialVideo();
    _loadInterstitialVideo2();
  }

  void _loadInterstitialVideo() {
    InterstitialAd.load(
      // adUnitId: 'ca-app-pub-3940256099942544/8691691433',
      adUnitId: 'ca-app-pub-8702651755109746/6819032904',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            this._isLoadedInterstitialVideo = true;
            this._interstitialVideoAd = ad;
          });
          // print('InterstitialAd Ad Loaded');
        },
        onAdFailedToLoad: (error) {
          // print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void _loadInterstitialVideo2() {
    InterstitialAd.load(
      // adUnitId: 'ca-app-pub-3940256099942544/8691691433',
      adUnitId: 'ca-app-pub-8702651755109746/6819032904',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            this._isLoadedInterstitialVideo2 = true;
            this._interstitialVideoAd2 = ad;
          });
          // print('InterstitialAd Ad Loaded');
        },
        onAdFailedToLoad: (error) {
          // print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* Aqui El Provider Se Tiene Que Redibujar */
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        /* Cuando Estoy En Un Tap O Click El Provider No Se Tiene Que Redibujar (listen: False)*/
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = widget.category.name;

        if (this.widget.category.name == 'entertainment' &&
            _isLoadedInterstitialVideo) {
          _interstitialVideoAd!.show();
        }

        if (this.widget.category.name == 'sports' &&
            _isLoadedInterstitialVideo2) {
          _interstitialVideoAd2!.show();
        }
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
          widget.category.icon,
          color: (newsService.selectedCategory == widget.category.name)
              ? tema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
