import 'package:flutter/material.dart';
import 'package:liquid/models/LoginState.dart';
import 'package:liquid/pages/admin/admin_dashboard/admin_dashboard.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/pages/auth_page/signup_page/signup_page.dart';
import 'package:liquid/pages/navigation.dart';
import 'package:liquid/pages/auth_page/signup_page/signup_welcome_page.dart';
import 'package:liquid/pages/splash_screen/splash_screen.dart';
import 'package:liquid/pages/venue_detail_page/venue_detail_page.dart';
import 'package:liquid/services/shared_preferences_helper.dart';
import 'package:provider/provider.dart';

void main() {
  SharedPreferencesHelper.shared.getUID().then((data) {
    if (data == '') {
      runApp(
        ChangeNotifierProvider(
          builder: (context) => LoginState(),
          child: MyApp(isLoggedIn: false,),
        ),
      );
    } else {
      SharedPreferencesHelper.shared.getUserData().then((data) {
        runApp(
          ChangeNotifierProvider(
            builder: (context) => LoginState(),
            child: MyApp(isLoggedIn: true,),
          ),
        );
      });
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isLoggedIn;
  MyApp({this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid',
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => new NavigationPage(),
        '/admin': (BuildContext context) => new AdminDashboard(),
        '/venue_detail': (BuildContext context) => new VenueDetailPage(),
        '/redeem': (BuildContext context) => new SignUpWelcomePage(),
        '/signin': (BuildContext context) => new SignInPage(),
        '/signup': (BuildContext context) => new SignUpPage(),
      },
      theme: ThemeData(
        fontFamily: "Helvetica",
        appBarTheme: AppBarTheme(color: Color(0xFF333333)),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(isLoggedIn: isLoggedIn,),
    );
  }
}
