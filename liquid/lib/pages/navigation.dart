import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid/pages/venue_list_page/venue_list_page.dart';

import 'main_page/main_page.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({Key key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    MainPage(),
    VenueListPage(),
    MainPage(),
    MainPage(),
    MainPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold);

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
        ),
        body: OrientationBuilder(builder: (context, orientation) {

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
            child: ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("Liquid Hospitality Card"),
                  accountEmail: new Text("info@liquid-dxb.com"),
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text("L"),
                  ),
                ),
                new ListTile(
                  title: new Text("Profile"),
                ),
                new ListTile(
                  title: new Text("About"),
                ),
                new ListTile(
                  title: new Text("Terms and Conditions"),
                ),
                new ListTile(
                  title: new Text("Privacy"),
                ),
//                new ListTile(
//                  title: new Text("Logout"),
//                  onTap: () {
//                    showDialog(
//                        context: context,
//                        builder: (BuildContext context) {
//                          return new AlertDialog(
//                            title: new Text('Are you sure?'),
//                            content: new Text('Do you want to log out?'),
//                            actions: <Widget>[
//                              new FlatButton(
//                                onPressed: () => Navigator.of(context).pop(false),
//                                child: new Text('No'),
//                              ),
//                              new FlatButton(
//                                onPressed: () {
//                                  //SharedPreferencesHelper.clearStoredData();
//                                  Navigator.of(context).pushNamedAndRemoveUntil(
//                                      '/login', (Route<dynamic> route) => false);
//                                },
//                                child: new Text('Yes'),
//                              ),
//                            ],
//                          );
//                        });
//                  },
//                ),
              ],
            )),
      ),
    );
  }
}
