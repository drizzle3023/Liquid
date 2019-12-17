import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/admin/admin_venue/admin_venue_add/admin_venue_add.dart';
import 'package:liquid/pages/admin/admin_venue/admin_venue_edit/admin_venue_edit.dart';

class AdminVenueList extends StatefulWidget {

  AdminVenueList({Key key}) : super(key: key);

  @override
  _AdminVenueListState createState() => _AdminVenueListState();
}

class _AdminVenueListState extends State<AdminVenueList> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Venue");
  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

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
                      "Venues",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                      child: StreamBuilder(
                          stream: databaseReference.onValue,
                          builder: (context, snap) {
                            if (snap.hasData &&
                                !snap.hasError &&
                                snap.data.snapshot.value != null) {
                              DataSnapshot snapshot = snap.data.snapshot;
                              List item = [];

                              snapshot.value.forEach((key, value) {
                                if (key != null && value != null)
                                  item.add(value);
                              });

                              item.sort((a, b) {
                                return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
                              });

                              return snap.data.snapshot.value == null
                                  ? SizedBox()
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Container(
                                          child: ListView.builder(
                                              itemCount: item.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.fromLTRB( 3.0, 0, 3, 0),
                                                  child: Card(
                                                    margin: EdgeInsets.all(1),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
                                                    elevation: 1,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width - 120,
                                                              child: Text( item[index]["name"].toString(),
                                                              overflow: TextOverflow.ellipsis,),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          child: Padding(
                                                            padding: EdgeInsets.all(12),
                                                            child: Text("Edit"),
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        AdminVenueEdit(venue: Venue.fromJson(item[index]),)));
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  )
                                                );
                                              })));
                            } else {
                              if (snap.hasData && snap.data.snapshot.value == null) {
                                return SizedBox();
                              }
                              return Center(child: CircularProgressIndicator());
                            }
                          }))
                ],
              ),
            );
          }),
        ),
        Positioned(
          right: 10,
          top: 85,
          child: FloatingActionButton(
            child: Text(
              "ADD\nNEW",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xfff15a24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminVenueAdd()),
              );
            },
          ),
        )
      ],
    );
  }
}
