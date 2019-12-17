import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid/pages/navigation.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  SplashScreen({this.isLoggedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NavigationPage(isLoggedIn: widget.isLoggedIn,)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/splash.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}