import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/screens/tab1_screen.dart';
import 'package:news_app/src/screens/tab2_screen.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _NavegationBottom(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}

class _NavegationBottom extends StatefulWidget {
  @override
  State<_NavegationBottom> createState() => _NavegationBottomState();
}

class _NavegationBottomState extends State<_NavegationBottom> {
  RewardedAd? rewardedAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RewardedAd.load(
      adUnitId: "ca-app-pub-3940256099942544/5224354917",
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
    final navegacionModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) {
        navegacionModel.paginaActual = value;

        if (value == 1 && this.isLoaded) {
          this.rewardedAd!.show(
            onUserEarnedReward: (ad, rewardItem) {
              // print("User Watched Complete Video");
            },
          );
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Para Ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;

    /* Page Controller Para Cambiar De Página */
    this._pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
