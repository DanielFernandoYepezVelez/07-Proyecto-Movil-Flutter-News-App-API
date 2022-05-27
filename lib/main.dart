import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/* Services Personal */
import 'package:news_api_flutter/services/news_service.dart';

/* Theme Of The Application */
import 'package:news_api_flutter/theme/tema.dart';

/* Complete Screen */
import 'package:news_api_flutter/screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
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
        title: 'Titulares',
        home: TabsScreen(),
      ),
    );
  }
}
