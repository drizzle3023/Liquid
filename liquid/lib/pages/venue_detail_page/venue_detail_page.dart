import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid/components/main_top_card.dart';
import 'package:liquid/pages/main_page/components/cards_column.dart';
import 'package:liquid/pages/main_page/components/fb_venues_slider.dart';
import 'package:liquid/pages/main_page/components/lifestyle_locations_slider.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_bottom_slider.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_contact.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_header.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_top_slider.dart';

import 'components/venue_detail_redeem_button.dart';

class VenueDetailPage extends StatefulWidget {
  VenueDetailPage({Key key}) : super(key: key);

  @override
  _VenueDetailPageState createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 30,
          child: new Image.asset(
            "assets/appbar_logo.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      VenueDetailHeader(),
                      VenueDetailTopSlider(),
                      VenueDetailRedeemButton(),
                      VenueDetailContact(),
                      VenueDetailBottomSlider(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
//      bottomNavigationBar: BottomNavigationBar(
//        type: BottomNavigationBarType.fixed,
//        backgroundColor: Color(0xFF333333),
//        unselectedItemColor: Colors.white,
//        items: const <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.public),
//            title: Text('Venues'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.notifications_active),
//            title: Text('News'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.local_florist),
//            title: Text('Events'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.map),
//            title: Text('Map'),
//          ),
//        ],
//        currentIndex: _selectedIndex,
//        selectedItemColor: Colors.amber[800],
//        onTap: _onItemTapped,
//      ),
    );
  }
}
