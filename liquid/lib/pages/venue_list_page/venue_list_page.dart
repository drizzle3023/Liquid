import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_header.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_top_slider.dart';
import 'package:liquid/pages/venue_list_page/components/venue_item.dart';

import 'components/venue_list_header.dart';


class VenueListPage extends StatefulWidget {
  VenueListPage({Key key}) : super(key: key);

  @override
  _VenueListPageState createState() => _VenueListPageState();
}

class _VenueListPageState extends State<VenueListPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.bold);


        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return VenueListHeader();
                }
                return VenueItem(index - 1);
              },
              separatorBuilder: (BuildContext context, int index) => Container(),
            );
          },
        );

  }
}
