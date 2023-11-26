import 'package:flutter/material.dart';
import 'package:mausam/Activity/Home.dart';
import 'package:mausam/Activity/loading.dart';
import 'package:mausam/Activity/location.dart';

void main(){
  runApp(const mausam());
  //debugPaintSizeEnabled = true;
}

class mausam extends StatelessWidget {
  const mausam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Anux",
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   pageTransitionsTheme: const PageTransitionsTheme(
      //     builders: {
      //       TargetPlatform.android : CupertinoPageTransitionsBuilder()
      //     }
      //   )
      // ),
      initialRoute: '/loading',

      routes: {
        //"/" : (context) => const loading(),
        "/Home" : (context) => const Home(),
        "/location" : (context) => const location(),
        "/loading" : (context) => const loading(),
      },
    );
  }
}
