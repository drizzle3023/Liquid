import 'package:async/async.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:liquid/pages/venue_list_page/components/venue_item.dart';
import 'package:liquid/services/location_helper.dart';
import 'package:location/location.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var location = new Location();

  var _searchFieldController = new TextEditingController();
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Venue");
  int _orderType = 1;

  @override
  void dispose() {
    super.dispose();
    _searchFieldController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchFieldController.addListener(doSearch);
  }

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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/main', (Route<dynamic> route) => false);
                  },
                )),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: new Theme(
                      data: new ThemeData(
                          primaryColor: Color(0xfff15a24), hintColor: Color(0xfff15a24)),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: new TextField(
                            controller: _searchFieldController,
                            style: new TextStyle(color: Color(0xfff15a24)),
                            decoration: InputDecoration(
                              hintText: 'Search for venues',
                              contentPadding:
                              EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xfff15a24)),
                                  ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xfff15a24)),
                                  ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xfff15a24),
                              ),
                            )),
                      ),
                    ),
                ),
                Expanded(
                  child: _searchFieldController.text == null || _searchFieldController.text == "" ? Container() :
                  FutureBuilder(
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
//            _list = snapshot.value;
                              snapshot.value.forEach((key, value) {
                                if (key != null &&
                                    value != null &&
                                    value["isActive"] == true &&
                                    value["name"].toString().toLowerCase().contains(_searchFieldController.text.toLowerCase()) == true
                                ) {
                                  var distance = LocationHelper.shared
                                      .calculateDistance(
                                      projectSnap.data == null
                                          ? 0
                                          : projectSnap.data.latitude,
                                      projectSnap.data == null
                                          ? 0
                                          : projectSnap.data.longitude,
                                      double.parse(value["latitude"]),
                                      double.parse(value["longitude"]));
                                  value["distance"] = distance;
                                  item.add(value);
                                }
                              });

                              if (_orderType == 2) {
                                item.sort((a, b) {
                                  return a['name']
                                      .toLowerCase()
                                      .compareTo(b['name'].toLowerCase());
                                });
                              } else {
                                item.sort(
                                        (a, b) => a["distance"] > b["distance"] ? 1 : -1);
                              }

                              return snap.data.snapshot.value == null
                                  ? SizedBox()
                                  : ListView.separated(
                                      itemCount: item.length,
                                      itemBuilder: (context, index) {
//                                if (index == 0) {
//                                  return VenueListHeader();
//                                }
                                        return VenueItem(
                                          item: item[index],
                                          currentLocation: projectSnap.data,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                          Container(),
                                    );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          });
                    },
                  ),
                )
              ],
            ),
         ),
      ],
    );
  }

  doSearch() {
    setState(() {

    });
  }

  _getLocation() async {
    return this._memoizer.runOnce(() async {
      var result = await location.getLocation();
      return result;
    });
  }
}
