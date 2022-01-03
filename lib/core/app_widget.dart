import 'package:flutter/material.dart';
import 'package:intoxianimeapi/home/presenter/content.page.dart';
import 'package:intoxianimeapi/home/presenter/home.page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intoxi Animes API',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/content': (context) => const ContentPage(),
      },
    );
  }
}
