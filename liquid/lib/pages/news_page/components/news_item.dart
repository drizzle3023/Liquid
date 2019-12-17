import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/News.dart';

class NewsItem extends StatelessWidget {
  final News item;

  NewsItem({this.item});

  @override
  Widget build(BuildContext context) {

    var date = new DateTime.fromMillisecondsSinceEpoch((int.tryParse(item.datetime.toString()) ?? 0 ));
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xFFEEEEEE),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item.title.length <= 30 ? item.title : item.title.substring(0,30) + "...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            Text(DateFormat("dd MMM yyyy hh:mm").format(date), style: TextStyle(fontSize: 13))
                          ],
                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          children: <Widget>[
//                            Text(item.title.length <= 30 ? item.title : item.title.substring(0,30) + "...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
//                            Text(DateFormat("dd MMM yyyy hh:mm").format(date), style: TextStyle(fontSize: 14))
//                          ],
//                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(item.content, textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                          ],
                        ),
                      ],
                    ),
                  )

                ),
              ],
            )),
      ),
    );
  }

}
