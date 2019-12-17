import 'package:async/async.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/pages/venue_list_page/components/venue_item.dart';
import 'package:liquid/services/location_helper.dart';
import 'package:location/location.dart';

class ClosestFBPage extends StatefulWidget {
  ClosestFBPage({Key key}) : super(key: key);

  @override
  _ClosestFBPageState createState() => _ClosestFBPageState();
}

class _ClosestFBPageState extends State<ClosestFBPage> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Venue");
  var location = new Location();
  final AsyncMemoizer _memoizer = AsyncMemoizer();
//  LocationData currentLocation;
  int _orderType = 1;

  @override
  void initState() {
    super.initState();
//    location.getLocation().then((val) {
//      currentLocation = val;
//    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
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
          )
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

                        snapshot.value.forEach((key, value) {
                          if (key != null && value != null) {
                            var distance = LocationHelper.shared.calculateDistance(
                                projectSnap.data == null ? 0 : projectSnap.data.latitude,
                                projectSnap.data == null ? 0 : projectSnap.data.longitude,
                                double.parse(value["latitude"]),
                                double.parse(value["longitude"]));
                            value["distance"] = distance;
                            if (value["category"] != null &&
                                value["category"]["id"] == 1 && value["isActive"] == true) {
                              item.add(value);
                            }
                          }
                        });

                        if (_orderType == 2) {
                          item.sort((a, b) {
                            return a['name']
                                .toLowerCase()
                                .compareTo(b['name'].toLowerCase());
                          });
                        } else {
                          item.sort((a, b) => a["distance"] > b["distance"] ? 1 : -1);
                        }

                        return snap.data.snapshot.value == null
                            ? SizedBox()
                            : Column(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0, right: 5),
                                                  child: Container(
                                                    child: RaisedButton(
                                                      padding: EdgeInsets.all(2),
                                                      child: new Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          new Icon(
                                                            Icons.sort_by_alpha,
                                                            size: 14,
                                                          ),
                                                          new SizedBox(
                                                            width: 5,
                                                          ),
                                                          new Text(
                                                            "ORDER BY NAME",
                                                            style:
                                                            TextStyle(fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _orderType = 2;
                                                        });
                                                      },
                                                      color: _orderType == 2
                                                          ? Colors.blueAccent
                                                          : Colors.white,
                                                      textColor: _orderType == 2
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 0),
                                                  child: Container(
                                                    child: RaisedButton(
                                                      padding: EdgeInsets.all(2),
                                                      child: new Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          new Icon(
                                                            Icons.sort,
                                                            size: 14,
                                                          ),
                                                          new SizedBox(
                                                            width: 5,
                                                          ),
                                                          new Text(
                                                            "ORDER BY DISTANCE",
                                                            style:
                                                            TextStyle(fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _orderType = 1;
                                                        });
                                                      },
                                                      color: _orderType == 1
                                                          ? Colors.blueAccent
                                                          : Colors.white,
                                                      textColor: _orderType == 1
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                )),
                                          ])),
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: item.length,
                                      itemBuilder: (context, index) {
                                        return VenueItem(item: item[index], currentLocation: projectSnap.data,);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                          Container(),
                                    ),
                                  ),
                                ],
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

  _getLocation() async {
    return this._memoizer.runOnce(() async {
      var result = await location.getLocation();
      return result;
    });
  }
}
