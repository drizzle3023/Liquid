import 'package:flutter/material.dart';
import 'package:liquid/pages/main_page/main_page.dart';
import 'package:liquid/pages/navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xFF333333)),
        primarySwatch: Colors.blue,
      ),
      home: NavigationPage(),
    );
  }
}
