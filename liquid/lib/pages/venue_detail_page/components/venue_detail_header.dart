import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';
import 'package:liquid/models/Venue.dart';

class VenueDetailHeader extends StatelessWidget {
  final Venue venue;
  VenueDetailHeader({this.venue});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Helvetica', fontSize: 25, fontWeight: FontWeight.bold);

    return Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                venue.name,
                overflow: TextOverflow.visible,
                maxLines: 2,
                style: style,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(child: Text(venue.subCategory.name)),
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
                  child: Container(child: Text(double.parse(venue.distance.toString()).toStringAsFixed(2) + " km"), alignment: Alignment.centerRight,),
                ),
              ],
            )
          ],
        ));
  }
}
