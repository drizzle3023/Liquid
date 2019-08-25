import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';

class VenueItem extends StatelessWidget {
  final int index;

  const VenueItem(this.index);

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      "assets/venue_list/venue_item_1.png",
      "assets/venue_list/venue_item_2.png",
      "assets/venue_list/venue_item_3.png",
      "assets/venue_list/venue_item_4.png",
    ];
    List<String> names = [
      "McSweeney's",
      "Sam's Bar",
      "Lemontree Lounge",
      "Centro Goue",
    ];
    List<String> category = [
      "Bar/lounge",
      "Bar/lounge",
      "Restaurant/Cafe",
      "Restaurant/Cafe",
    ];
    List<String> distance = [
      "0.31km",
      "0.89km",
      "1.20km",
      "1.50km",
    ];

    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                new Image.asset(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Color(0xFFEEEEEE),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(names[index], style: TextStyle(fontSize: 18),),
                            Text(distance[index], style: TextStyle(fontSize: 15))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(category[index]),
                            StarDisplay(
                              value: 5,
                            )
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
