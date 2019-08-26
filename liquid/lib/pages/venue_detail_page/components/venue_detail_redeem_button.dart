import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';

class VenueDetailRedeemButton extends StatelessWidget {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 5),
      child: Container(
        color: Color(0xFFF15A24),
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Text(
                    "DISCOUNT OFFERED:40%",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("CLICK TO REDEEM",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            onTap: () {

            },
          ),
        ),
      ),
    );
  }
}
