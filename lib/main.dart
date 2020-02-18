import 'package:flutter/material.dart';
import 'package:flutter_application/about.dart';
import 'package:flutter_application/home.dart';
import 'package:flutter_application/news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter NCP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      /*home: MyHomePage(title: '新冠肺炎疫情实时追踪'),*/
      routes: {
        '/': (context) => MyHomePage(title: '新冠肺炎疫情实时追踪'),
        '/news': (context) => MyNewsPage(title: "疫情新闻数据",),
        '/about': (context) => MyAboutPage()
      },
      initialRoute: '/',
    );
  }
}
