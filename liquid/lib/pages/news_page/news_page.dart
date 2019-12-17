
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/News.dart';
import 'package:liquid/pages/news_page/components/news_item.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

    final databaseReference =
      FirebaseDatabase.instance.reference().child("News");


  @override
  Widget build(BuildContext context) {

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
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return NewsItem(item: new News.fromJson(item[index]));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(),
                );
              } else {
                if (snap.hasData && snap.data.snapshot.value == null) {
                  return SizedBox();
                }
                return Center(child: CircularProgressIndicator());
              }
            });
  }

}
