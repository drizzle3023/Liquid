import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';
import 'package:liquid/models/Venue.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueDetailContact extends StatelessWidget {
  final Venue venue;
  VenueDetailContact({this.venue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Color(0xFFEEEEEE),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("About " + venue.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  Text(venue.about ?? "")
                ],
              ),
            )
          ),

          Container(
            color: Color(0xFFEEEEEE),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(venue.address2 ?? ""),
                            Text(venue.address1 ?? ""),
                            Text(venue.city ?? ""),
                            Text(venue.country ?? ""),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Container(
                        child: new Image.asset(
                            "assets/venue_detail/venue_detail_address.jpg"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: Container(
                      color: Color(0xFFEEEEEE),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Center(
                          child: Text(
                            venue.phone,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Container(
                      color: Color(0xFFEEEEEE),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Center(
                            child: Text(
                              venue.email,
                          style: TextStyle(fontSize: 12),
                        )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: Container(
                      color: Color(0xFFEEEEEE),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: Center(
                                child: Text(
                              "Opening hours:",
                              style: TextStyle(fontSize: 14),
                            )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(venue.openingHours),
                                  //Text("(Friday 9AM - 3AM)")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Container(
                        color: Color(0xFFEEEEEE),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                              child: Center(
                                  child: Text(
                                "Check us on:",
                                style: TextStyle(fontSize: 14),
                              )),
                            ),
                            Container(
                              height: 80,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      (venue.instagramUrl != null && venue.instagramUrl.length > 0) ?
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_instagram.png"),
                                              onTap: () async {
                                                final url = venue.instagramUrl;
                                                if (await canLaunch(url)) {
                                                await launch(url);
                                                } else {
                                                throw 'Could not launch $url';
                                                }
                                              }
                                              ,
                                            ),
                                          )) : Container(),
                                      (venue.facebookUrl != null && venue.facebookUrl.length > 0) ?
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_facebook.png"),
                                              onTap: () async {
                                                final url = venue.facebookUrl;
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }
                                            ),
                                          )):Container(),
                                      (venue.twitterUrl != null && venue.twitterUrl.length > 0) ?
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_twitter.png"),
                                              onTap: () async {
                                                final url = venue.twitterUrl;
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }
                                            ),
                                          )) : Container(),
                                      (venue.youtubeUrl != null && venue.youtubeUrl.length > 0) ?
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_youtube.png"),
                                              onTap: () async {
                                                final url = venue.youtubeUrl;
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }
                                            ),
                                          )) : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
