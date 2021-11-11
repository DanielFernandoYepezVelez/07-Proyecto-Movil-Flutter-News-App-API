import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/* Services Pesonal */
import 'package:news_app/src/services/news_service.dart';

/* Tema Of The Application */
import 'package:news_app/src/theme/tema.dart';

/* Complete Screen */
import 'package:news_app/src/screens/tabs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new NewsService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: tema,
        title: 'Headlines App',
        home: TabsScreen(),
      ),
    );
  }
}
