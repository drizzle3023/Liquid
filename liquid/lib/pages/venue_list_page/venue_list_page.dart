import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:liquid/pages/venue_list_page/components/venue_item.dart';
import 'package:location/location.dart';

import 'components/venue_list_header.dart';

class VenueListPage extends StatefulWidget {
  VenueListPage({Key key}) : super(key: key);

  @override
  _VenueListPageState createState() => _VenueListPageState();
}

class _VenueListPageState extends State<VenueListPage> {
  var location = new Location();

    final databaseReference =
      FirebaseDatabase.instance.reference().child("Venue");


  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.bold);

    return FutureBuilder(
      future: _getLocation(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, snap) {
              if (snap.hasData &&
                  !snap.hasError &&
                  snap.data.snapshot.value != null) {
                DataSnapshot snapshot = snap.data.snapshot;
                List item = [];
                List _list = [];

//            _list = snapshot.value;
                snapshot.value.forEach((key, value) {
                  if (key != null && value != null) {
                    item.add(value);
                  }
                });

                return snap.data.snapshot.value == null
                    ? SizedBox()
                    : ListView.separated(
                  itemCount: item.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return VenueListHeader();
                    }
                    return VenueItem(item: item[index], currentLocation: projectSnap.data,);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
      },
    );


//            return ListView.separated(
//              padding: const EdgeInsets.all(8.0),
//              itemCount: 5,
//              itemBuilder: (BuildContext context, int index) {
//                if (index == 0) {
//                  return VenueListHeader();
//                }
//                return VenueItem(index - 1);
//              },
//              separatorBuilder: (BuildContext context, int index) => Container(),
//            );
//          },
//        );
  }

  Future <LocationData>_getLocation() async {

    var result = await location.getLocation();
    return result;
  }

}
