import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid/models/LoginState.dart';
import 'package:liquid/pages/about_page/about_page.dart';
import 'package:liquid/pages/admin/admin_event/admin_event_list/admin_event_list.dart';
import 'package:liquid/pages/admin/admin_faq/admin_static_text_terms.dart';
import 'package:liquid/pages/admin/admin_main_category/admin_main_category_list/admin_main_category_list.dart';
import 'package:liquid/pages/admin/admin_member/admin_member_list/admin_member_list.dart';
import 'package:liquid/pages/admin/admin_news/admin_news_list/admin_news_list.dart';
import 'package:liquid/pages/admin/admin_static_text/admin_static_text_list/admin_static_text_list.dart';
import 'package:liquid/pages/admin/admin_sub_category/admin_sub_category_list/admin_sub_category_list.dart';
import 'package:liquid/pages/admin/admin_venue/admin_venue_list/admin_venue_list.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/pages/help_page/help_page.dart';
import 'package:liquid/pages/navigation.dart';
import 'package:liquid/pages/privacy_page/privacy_page.dart';
import 'package:liquid/pages/profile_page/profile_page.dart';
import 'package:liquid/pages/search_page/search_page.dart';
import 'package:liquid/pages/terms_page/terms_page.dart';
import 'package:liquid/services/auth_helper.dart';
import 'package:liquid/services/shared_preferences_helper.dart';
import 'package:liquid/utils/globals.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {

  AdminDashboard({Key key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

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
          title: InkWell(
            child: Container(
              height: 30,
              child: new Image.asset(
                "assets/appbar_logo.png",
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
            },
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Liquid admin",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "VENUES",
                                          style: style,
                                        ),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminVenueList()));
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "MEMBERS",
                                          style: style,
                                        ),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminMemberList()),
                                    );
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "NEWS",
                                          style: style,
                                        ),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminNewsList()),
                                    );
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "INDUSTRY",
                                          style: style,
                                        ),
                                        SizedBox(height: 5,),
                                        Text("NIGHTS", style: style,)
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminEventList()),
                                    );
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "MAIN CAT.",
                                          style: style,
                                        ),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminMainCategoryList()),
                                    );
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "SUB-CAT.",
                                          style: style,
                                        ),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminSubCategoryList()),
                                    );
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "STATIC",
                                          style: style,
                                        ),
                                        SizedBox(height: 5,),
                                        Text("TEXTS", style: style,)
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminStaticTextList()));
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 250) * 0.25 - 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("ADMIN", style: style),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "SUPPORT",
                                          style: style,
                                        ),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminFAQ()));
                                  },
                                  color: Color(0xfff15a24),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
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
                        accountName: new Text(Globals.loginedUser.firstName +
                            " " +
                            Globals.loginedUser.lastName),
                        accountEmail: new Text(Globals.loginedUser.email),
                        currentAccountPicture: new CircleAvatar(
                          backgroundColor: Colors.white,
                          child: new Text(
                              Globals.loginedUser.firstName.substring(0, 1)),
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
                                  builder: (context) => SignInPage()));
                        },
                      )
                          : Container();
                    },
                  ),
                  Consumer<LoginState>(
                    builder: (context, loginState, child) {
                      return Globals.loginedUser != null &&
                          Globals.loginedUser.email == Globals.adminEmail
                          ? ListTile(
                        title: Text("Main Page"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
                        },
                      )
                          : Container();
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NavigationPage(isLoggedIn: false,)));
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
