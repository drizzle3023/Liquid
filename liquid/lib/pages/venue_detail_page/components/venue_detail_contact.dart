import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';

class VenueDetailContact extends StatelessWidget {
  final dynamic venue;
  VenueDetailContact({this.venue});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.bold);
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        children: <Widget>[
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
                            Text(
                                venue["address2"] ?? ""),
                            Text(venue["address1"] ?? ""),
                            Text(venue["city"] ?? ""),
                            Text(venue["country"] ?? ""),
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
                            "assets/venue_detail/venue_detail_address.png"),
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
                            venue["phone"] ?? "",
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
                              venue["email"] ?? "",
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
          Container(
            child: Row(
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
                          SizedBox(
                            height: 50,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(venue["opening_hours"] ?? ""),
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
                            SizedBox(
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 25,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_instagram.png"),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 25,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_facebook.png"),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 25,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_twitter.png"),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 25,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: InkWell(
                                              child: new Image.asset(
                                                  "assets/icons/icon_youtube.png"),
                                            ),
                                          )),
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
