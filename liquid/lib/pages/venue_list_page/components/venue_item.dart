import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';
import 'package:liquid/pages/venue_detail_page/venue_detail_page.dart';
import 'package:location/location.dart';

class VenueItem extends StatelessWidget {
  final dynamic item;
  final LocationData currentLocation;

  VenueItem({this.item, this.currentLocation});

  @override
  Widget build(BuildContext context) {
//    List<String> imageUrls = [
//      "assets/venue_list/venue_item_1.png",
//      "assets/venue_list/venue_item_2.png",
//      "assets/venue_list/venue_item_3.png",
//      "assets/venue_list/venue_item_4.png",
//    ];
//    List<String> names = [
//      "McSweeney's",
//      "Sam's Bar",
//      "Lemontree Lounge",
//      "Centro Goue",
//    ];
//    List<String> category = [
//      "Bar/lounge",
//      "Bar/lounge",
//      "Restaurant/Cafe",
//      "Restaurant/Cafe",
//    ];
//    List<String> distance = [
//      "0.31km",
//      "0.89km",
//      "1.20km",
//      "1.50km",
//    ];



    var distance = calculateDistance(currentLocation == null ? 0 : currentLocation.latitude, currentLocation == null ? 0 : currentLocation.longitude, double.parse(item["latitude"]), double.parse(item["longitude"]));
    item["distance"] = distance;

    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        Center(child: new Icon(Icons.error)),
                    imageUrl: item["mainImage"] ?? "",
                    fit: BoxFit.contain,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VenueDetailPage(venue: item,)));
                  },
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
                            Text(item["name"].toString().length <= 25 ? item["name"] : item["name"].toString().substring(0,25) + "...", style: TextStyle(fontSize: 18),),
                            Text(item["distance"] != null ? double.parse(item["distance"].toString()).toStringAsFixed(2) + " km" : "n/a km", style: TextStyle(fontSize: 15))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item["category"]),
//                            StarDisplay(
//                              value: 5,
//                            )
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

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

}
