import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';

class VenueDetailContact extends StatelessWidget {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
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
                                "Grosvenor House, M floor 323 Al Jalillames Road"),
                            Text("Dubai Marina"),
                            Text("Dubai"),
                            Text("United Arab Emirates"),
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
                            "+971 42 235 8450",
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
                          "info@mcsweeneysbar.ae",
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
                                  Text("11AM - 2AM"),
                                  Text("(Friday 9AM - 3AM)")
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
