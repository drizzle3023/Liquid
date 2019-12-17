import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid/models/LoginState.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/pages/event_page/event_page.dart';
import 'package:liquid/pages/help_page/help_page.dart';
import 'package:liquid/pages/map_page/map_page.dart';
import 'package:liquid/pages/news_page/news_page.dart';
import 'package:liquid/pages/privacy_page/privacy_page.dart';
import 'package:liquid/pages/profile_page/profile_page.dart';
import 'package:liquid/pages/search_page/search_page.dart';
import 'package:liquid/pages/terms_page/terms_page.dart';
import 'package:liquid/pages/venue_list_page/venue_list_page.dart';
import 'package:liquid/services/auth_helper.dart';
import 'package:liquid/services/shared_preferences_helper.dart';
import 'package:liquid/utils/globals.dart';
import 'package:provider/provider.dart';

import 'about_page/about_page.dart';
import 'main_page/main_page.dart';

class NavigationPage extends StatefulWidget {
  final bool isLoggedIn;
  NavigationPage({Key key, this.isLoggedIn}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int _selectedIndex = 0;

  final List<Widget> _children = [
    MainPage(),
    VenueListPage(),
    NewsPage(),
    EventPage(),
    MapPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit?'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => exit(0),
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            height: 30,
            child: new Image.asset(
              "assets/appbar_logo.png",
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white,),
              tooltip: 'Search',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage()));
              },
            ),
          ],
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (_selectedIndex == 0) {
            return MainPage(onIndustryNightsSelected: (){
              setState(() {
                _selectedIndex = 3;
              });
            },);
          }
          return _children[_selectedIndex];
        }),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF333333),
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              title: Text('Venues'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              title: Text('News'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_florist),
              title: Text('Events'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        drawer: Drawer(
            child: Column(
          children: <Widget>[
            Consumer<LoginState>(
              builder: (context, loginState, child) {
                return !loginState.isLoggedIn && Globals.loginedUser == null
                    ? new UserAccountsDrawerHeader(
                        accountName: new Text("Liquid Hospitality Card"),
                        accountEmail: new Text("info@liquid-dxb.com"),
                        currentAccountPicture: new CircleAvatar(
                          backgroundColor: Colors.white,
                          child: new Text("L"),
                        ),
                      )
                    : new UserAccountsDrawerHeader(
                        accountName: new Text((Globals.loginedUser.firstName ?? "") +
                            " " +
                            (Globals.loginedUser.lastName ?? "" )),
                        accountEmail: new Text(Globals.loginedUser.email),
                        currentAccountPicture: new CircleAvatar(
                          backgroundColor: Colors.white,
                          child: new Text(
                              Globals.loginedUser.firstName != null ? Globals.loginedUser.firstName.substring(0, 1) :
                              Globals.loginedUser.lastName.substring(0, 1) ),
                        ),
                      );
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Consumer<LoginState>(
                    builder: (context, loginState, child) {
                      return !loginState.isLoggedIn && Globals.loginedUser == null
                          ? ListTile(
                        title: Text("Sign In"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignInPage()));
                        },
                      )
                          : Container(height: 0,);
                    },
                  ),
                  Consumer<LoginState>(
                    builder: (context, loginState, child) {
                      return Globals.loginedUser != null && Globals.loginedUser.email == Globals.adminEmail
                          ? ListTile(
                        title: Text("Admin"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/admin', (Route<dynamic> route) => false);
                        },
                      )
                          : Container(height: 0,);
                    },
                  ),
                  Consumer<LoginState>(
                    builder: (context, loginState, child) {
                      return Globals.loginedUser != null
                          ? ListTile(
                              title: new Text("Profile"),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage()));
                              },
                            )
                          : Container(height: 0,);
                    },
                  ),
                  new ListTile(
                    title: new Text("Search"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
                  ),
                  new ListTile(
                    title: new Text("About Us"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutPage()));
                    },
                  ),
                  new ListTile(
                    title: new Text("Terms and Conditions"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsPage()));
                    },
                  ),
                  new ListTile(
                    title: new Text("Privacy"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPage()));
                    },
                  ),
                  new ListTile(
                    title: new Text("Help/Support"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HelpPage()));
                    },
                  ),
                  Consumer<LoginState>(
                    builder: (context, loginState, child) {
                      return loginState.isLoggedIn || Globals.loginedUser != null
                          ? new ListTile(
                          title: new Text("Logout"),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new AlertDialog(
                                    title: new Text('Are you sure?'),
                                    content: new Text('Do you want to Logout?'),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: new Text('No'),
                                      ),
                                      new FlatButton(
                                        onPressed: () {
                                          SharedPreferencesHelper
                                              .clearStoredData();
                                          Globals.loginedUser = null;
                                          Auth.signOut();
                                          Provider.of<LoginState>(context)
                                              .logout();
                                          Navigator.of(context).pop(false);
                                          Navigator.pop(context);
                                        },
                                        child: new Text('Yes'),
                                      ),
                                    ],
                                  );
                                });
                          })
                          : Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
