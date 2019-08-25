import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';

class VenueDetailHeader extends StatelessWidget {
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
                "McSweeney's",
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
                  flex: 3,
                  child: Container(child: Text("Bar/lounge")),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                      child: StarDisplay(
                    value: 5,
                  )),
                ),
                Expanded(
                  flex: 3,
                  child: Container(child: Text("0.31 km"), alignment: Alignment.centerRight,),
                ),
              ],
            )
          ],
        ));
  }
}
