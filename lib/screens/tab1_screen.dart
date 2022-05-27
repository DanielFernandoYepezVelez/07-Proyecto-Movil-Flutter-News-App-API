import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'package:news_api_flutter/services/news_service.dart';

import 'package:news_api_flutter/widgets/list_news.dart';

class Tab1Screen extends StatefulWidget {
  @override
  _Tab1ScreenState createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen>
    with AutomaticKeepAliveClientMixin {
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
                  height: 300,
                  child: !_isLoadedVideoNative
                      ? FadeInImage(
                          placeholder: AssetImage('assets/img/giphy.gif'),
                          image: AssetImage('assets/img/giphy.gif'),
                        )
                      : AdWidget(ad: _nativeVideoAd!),
                ),
              ],
            ),
          ),
          Expanded(
            child: (newsService.headlines.length == 0)
                ? Center(child: CircularProgressIndicator())
                : ListNews(newsService.headlines),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
