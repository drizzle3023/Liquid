import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid/components/main_top_card.dart';
import 'package:liquid/pages/main_page/components/cards_column.dart';
import 'package:liquid/pages/main_page/components/fb_venues_slider.dart';
import 'package:liquid/pages/main_page/components/lifestyle_locations_slider.dart';
import 'package:liquid/pages/venue_detail_page/venue_detail_page.dart';
import 'package:liquid/pages/venue_list_page/venue_list_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold);

    return LayoutBuilder(
      builder:
          (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight - 100,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  MainTopCardColumn(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                    child: Container(
                      height: 35,
                      color: Color(0xFFF15A24),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Closest F&B venues",
                                style: TextStyle(color: Colors.white)),
                            InkWell(
                              child: Text("See all",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) =>
//                                            VenueListPage()));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  FBVenuesSlider(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                    child: Container(
                      height: 35,
                      color: Color(0xFFF15A24),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Closest F&B venues",
                                style: TextStyle(color: Colors.white)),
                            InkWell(
                              child: Text("See all",
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) =>
//                                            VenueListPage()));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  LifeStyleLocationsSlider(),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
