import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/pages/venue_list_page/components/venue_item.dart';
import 'package:liquid/pages/venue_list_page/venue_list_page.dart';
import 'package:location/location.dart';

import 'main_page/main_page.dart';

class ClosestFBPage extends StatefulWidget {
  ClosestFBPage({Key key}) : super(key: key);

  @override
  _ClosestFBPageState createState() => _ClosestFBPageState();
}

class _ClosestFBPageState extends State<ClosestFBPage> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Venue");
  var location = new Location();

//  LocationData currentLocation;

  @override
  void initState() {
    super.initState();
//    location.getLocation().then((val) {
//      currentLocation = val;
//    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold);

    return WillPopScope(
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
                            var distance = calculateDistance(
                                projectSnap.data.longitude,
                                projectSnap.data.longitude,
                                double.parse(value["latitude"]),
                                double.parse(value["longitude"]));
                            value["distance"] = distance;
                            if (value["category"] != null &&
                                value["category"].toString() == "f&b") {
                              item.add(value);
                            }
                          }
                        });

                        item.sort(
                            (a, b) => a["distance"] > b["distance"] ? 1 : -1);

                        return snap.data.snapshot.value == null
                            ? SizedBox()
                            : ListView.separated(
                                itemCount: item.length,
                                itemBuilder: (context, index) {
                                  return VenueItem(item: item[index], currentLocation: projectSnap.data,);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Container(),
                              );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    });
              });
        }),
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<LocationData> _getLocation() async {
    var result = await location.getLocation();
    return result;
  }
}
