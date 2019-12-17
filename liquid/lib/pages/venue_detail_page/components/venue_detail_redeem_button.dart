import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/redeem_page/redeem_root_page.dart';

class VenueDetailRedeemButton extends StatelessWidget {
  final Venue venue;
  VenueDetailRedeemButton({this.venue});

  @override
  Widget build(BuildContext context) {
    String text1 = "";
    String text2 = "";
    if (venue.mainCategory != null) {
      if (venue.mainCategory.name == "F&B") {
        text1 = venue.discountFood;
        text2 = venue.discountBeverages;

        if (text1 == "0" || text1.length == 0) {
          text1 = '';
        } else {
          text1 = "DISCOUNT FOOD: " + text1 + "%";
        }
        if (text2 == "0" || text2.length == 0) {
          text2 = '';
        } else {
          text2 = "DISCOUNT BEVERAGE: " + text2 + "%";
        }
      } else if (venue.subCategory.name.toLowerCase() == "lifestyle") {
        text1 = venue.discountOther;
        if (text1.toString() == "0" || text1.length == 0) {
          text1 = '';
        } else {
          text1 = "DISCOUNT OFFER: " + text1 + "%";
        }
      }
    }
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
                  text1.length > 0 ? Text(
                    text1,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ) : Container(),
                  text2.length > 0 ? Text(
                    text2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ) : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("CLICK TO REDEEM",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RedeemRootPage()));
            },
          ),
        ),
      ),
    );
  }
}
