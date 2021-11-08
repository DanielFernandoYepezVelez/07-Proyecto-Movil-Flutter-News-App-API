import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/* Services */
import 'package:news_app/src/services/news_service.dart';

/* Models */
import 'package:news_app/src/models/category_models.dart';

/* Tema Application */
import 'package:news_app/src/theme/tema.dart';

class Tab2Screen extends StatefulWidget {
  @override
  State<Tab2Screen> createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  BannerAd? bannerAdTwo;
  bool isLoadedTwo = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: "ca-app-pub-8802721251339887/9665194968",
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            this.isLoaded = true;
          });
          // print("Banner Ad Loaded");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          // print("Banner Ad Failed $error");
        },
      ),
    );

    this.bannerAdTwo = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: "ca-app-pub-8802721251339887/9665194968",
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            this.isLoadedTwo = true;
          });
          // print("Banner Ad Loaded");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          // print("Banner Ad Failed $error");
        },
      ),
    );

    this.bannerAd!.load();
    this.bannerAdTwo!.load();
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
                this.isLoaded
                    ? Container(
                        height: 50,
                        child: AdWidget(ad: this.bannerAd!),
                      )
                    : SizedBox(),
                SizedBox(height: 15),
                _ListCategory(),
                this.isLoadedTwo
                    ? Container(
                        height: 50,
                        child: AdWidget(ad: this.bannerAdTwo!),
                      )
                    : SizedBox(),
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

class _CategoryBotton extends StatefulWidget {
  final Category category;

  const _CategoryBotton(this.category);

  @override
  State<_CategoryBotton> createState() => _CategoryBottonState();
}

class _CategoryBottonState extends State<_CategoryBotton> {
  RewardedAd? rewardedAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RewardedAd.load(
      adUnitId: "ca-app-pub-8802721251339887/2141928160",
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            this.isLoaded = true;
          });
          this.rewardedAd = ad;
          // print("Rewarded Ad Loaded");
        },
        onAdFailedToLoad: (error) {
          // print("Rewarded Ad Failed To Load $error");
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

        if (this.widget.category.name == 'general') {
          this.rewardedAd!.show(
            onUserEarnedReward: (ad, rewardItem) {
              // print("User Watched Complete Video");
            },
          );
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
