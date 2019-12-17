
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/pages/admin/admin_check_photos/admin_check_photos.dart';
import 'package:liquid/pages/admin/admin_event/admin_event_add/admin_event_add.dart';
import 'package:liquid/utils/globals.dart';
import 'package:toast/toast.dart';

class AdminEventList extends StatefulWidget {
  AdminEventList({Key key}) : super(key: key);

  @override
  _AdminEventListState createState() => _AdminEventListState();
}

class _AdminEventListState extends State<AdminEventList> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Event");
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/main', (Route<dynamic> route) => false);
                },
              )),
          body: OrientationBuilder(builder: (context, orientation) {
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Events",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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

                              return snap.data.snapshot.value == null
                                  ? SizedBox()
                                  : GridView.count(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          padding: EdgeInsets.all(5),
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          children: List.generate(item.length,
                                              (index) {
                                            var image = item[index]["image"];

                                            return new GridTile(
                                              child: new Card(
                                                  margin: EdgeInsets.all(0.0),
                                                  elevation: 3.0,
                                                  child: new InkWell(
                                                    child: new ClipRRect(
                                                      borderRadius: new BorderRadius.circular(3.0),
                                                      child: CachedNetworkImage(
                                                        placeholder: (context,
                                                            url) => Center(
                                                            child: CircularProgressIndicator()
                                                        ),
                                                        imageUrl: image,
                                                        fit: BoxFit.cover,
                                                      ),

                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => AdminCheckPhotosPage(
                                                            imageUrl: image,
                                                            )),
                                                      );
                                                    },
                                                  )),
                                              footer: new ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  3.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  3.0)),
                                                  child: GestureDetector(
                                                      onTap: () {

                                                      },
                                                      child: GridTileBar(
                                                        backgroundColor:
                                                            Colors.black45,
                                                        subtitle: Text(""),
                                                        trailing: InkWell(
                                                          child: Icon(
                                                          Icons.delete_forever,
                                                          color: Colors.white,
                                                        ),
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return new AlertDialog(
                                                                  title: new Text('Are you sure?'),
                                                                  content: new Text('Do you want to Delete this event?'),
                                                                  actions: <Widget>[
                                                                    new FlatButton(
                                                                      onPressed: () =>
                                                                          Navigator.of(context).pop(false),
                                                                      child: new Text('No'),
                                                                    ),
                                                                    new FlatButton(
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop(false);
                                                                        _deleteEvent(item[index]["imageId"]);
                                                                      },
                                                                      child: new Text('Yes'),
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        },),
                                                      ))),
                                            );
                                          }));
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
          top: 80,
          child: FloatingActionButton(
            child: Text(
              "ADD\nNEW",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xfff15a24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminEventAdd()),
              );
            },
          ),
        )
      ],
    );
  }

  void _deleteEvent(String imageId) async {
    databaseReference.child(imageId).remove().then((_) {
      Globals.shared.showToast(context, "Successfully deleted the event.",
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
  }
}
