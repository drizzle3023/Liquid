import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid/components/star_rating.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/venue_detail_page/venue_detail_page.dart';
import 'package:liquid/services/location_helper.dart';
import 'package:location/location.dart';

class VenueItem extends StatelessWidget {
  final dynamic item;
  final LocationData currentLocation;

  VenueItem({this.item, this.currentLocation});

  @override
  Widget build(BuildContext context) {

    var distance = LocationHelper.shared.calculateDistance(currentLocation == null ? 0 : currentLocation.latitude, currentLocation == null ? 0 : currentLocation.longitude, double.parse(item["latitude"]), double.parse(item["longitude"]));
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
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VenueDetailPage(venue: Venue.fromJson(item))));
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
                            Text(item["subCategory"]["name"]),
                            Text(item["distance"] != null ? double.parse(item["distance"].toString()).toStringAsFixed(2) + " km" : "n/a km", style: TextStyle(fontSize: 15))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: Text(item["name"], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16),),
                            )

//                            StarDisplay(
//                              value: 5,
//                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            (item["address3"] != null) ?
                            Text(item["address3"], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15),) :
                            Text(""),
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
