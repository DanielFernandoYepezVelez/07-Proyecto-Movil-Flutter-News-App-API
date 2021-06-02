import 'package:flutter/material.dart';

import 'package:news_app/src/screens/tabs_screen.dart';

import 'package:news_app/src/theme/tema.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema,
      title: 'Material App',
      home: TabsScreen(),
    );
  }
}
