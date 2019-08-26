import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';

class VenueDetailHeader extends StatelessWidget {
  final dynamic venue;
  VenueDetailHeader({this.venue});
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                venue["name"].toString().length > 20 ? venue["name"].toString().substring(0, 20) + "..." : venue["name"],
                style: style,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(child: Text(venue["category"])),
                ),
//                Expanded(
//                  flex: 4,
//                  child: Center(
//                      child: StarDisplay(
//                    value: 5,
//                  )),
//                ),
                Expanded(
                  flex: 5,
                  child: Container(child: Text(double.parse(venue["distance"].toString()).toStringAsFixed(2) + " km"), alignment: Alignment.centerRight,),
                ),
              ],
            )
          ],
        ));
  }
}
