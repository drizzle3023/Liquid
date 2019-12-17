import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/LoginState.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/admin/admin_static_text/admin_static_text_about/admin_static_text_about.dart';
import 'package:liquid/pages/admin/admin_static_text/admin_static_text_privacy/admin_static_text_privacy.dart';
import 'package:liquid/pages/admin/admin_static_text/admin_static_text_terms/admin_static_text_terms.dart';
import 'package:liquid/pages/admin/admin_venue/admin_venue_add/admin_venue_add.dart';
import 'package:liquid/pages/admin/admin_venue/admin_venue_edit/admin_venue_edit.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/services/auth_helper.dart';
import 'package:liquid/services/shared_preferences_helper.dart';
import 'package:liquid/utils/globals.dart';
import 'package:provider/provider.dart';

class AdminStaticTextList extends StatefulWidget {

  AdminStaticTextList({Key key}) : super(key: key);

  @override
  _AdminStaticTextListState createState() => _AdminStaticTextListState();
}

class _AdminStaticTextListState extends State<AdminStaticTextList> {
  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
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
            )
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
                      "Static Texts",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: FlatButton(
                            child: Container(
                                width: double.infinity,
                                child: Text("About Us", style: style, textAlign: TextAlign.center,)
                            ),
                            padding: EdgeInsets.all(12),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminStaticTextAbout()));
                            },
                            color: Color(0xfff15a24),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: FlatButton(
                            child: Container(
                              child: Text("Terms and Conditions", style: style, textAlign: TextAlign.center,),
                              width: double.infinity,
                            ),
                            padding: EdgeInsets.all(12),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminStaticTextTerms()));
                            },
                            color: Color(0xfff15a24),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: FlatButton(
                            child: Container(
                              width: double.infinity,
                              child: Text("Privacy", style: style, textAlign: TextAlign.center,)
                            ),
                            padding: EdgeInsets.all(12),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminStaticTextPrivacy()));
                            },
                            color: Color(0xfff15a24),
                          ),
                        ),
                      ],
                    ),)
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
