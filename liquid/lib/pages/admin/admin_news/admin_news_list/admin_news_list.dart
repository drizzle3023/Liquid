import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/News.dart';
import 'package:liquid/pages/admin/admin_news/admin_news_add/admin_news_add.dart';
import 'package:liquid/pages/admin/admin_news/admin_news_edit/admin_news_edit.dart';

class AdminNewsList extends StatefulWidget {

  AdminNewsList({Key key}) : super(key: key);

  @override
  _AdminNewsListState createState() => _AdminNewsListState();
}

class _AdminNewsListState extends State<AdminNewsList> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("News");
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
                      "News",
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
                                return a['title'].toLowerCase().compareTo(b['title'].toLowerCase());
                              });

                              return snap.data.snapshot.value == null
                                  ? SizedBox()
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Container(
                                          height: MediaQuery.of(context).size.height * 0.25,
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
                                                          padding: EdgeInsets.all(10),
                                                            child: Container(
                                                              child: Text( item[index]["title"].toString().length > 30 ?
                                                              item[index]["title"].toString().substring(0, 30) + "..." :
                                                              item[index]["title"].toString() ),
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
                                                                        AdminNewsEdit(news: News.fromJson(item[index]),)
                                                                        ));
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
                MaterialPageRoute(builder: (context) => AdminNewsAdd()),
              );
            },
          ),
        )
      ],
    );
  }
}
