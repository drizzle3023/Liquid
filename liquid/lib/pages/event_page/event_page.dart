import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class EventPage extends StatefulWidget {
  EventPage({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Event");

  @override
  void initState() {
    super.initState();
  }

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

            snapshot.value.forEach((key, value) {
              if (key != null && value != null) item.add(value);
            });

            return LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Center(
                              child: new Icon(Icons.error)),
                      imageUrl: item[index]["image"] ?? "",
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: item.length,
                  loop: true,
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
