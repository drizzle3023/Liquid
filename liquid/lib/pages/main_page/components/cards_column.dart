import 'package:flutter/material.dart';
import 'package:liquid/components/main_top_card.dart';

class MainTopCardColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: MainTopCard("assets/main_page/main_top_3.png"),
                ),
                Expanded(
                  flex: 5,
                  child: MainTopCard("assets/main_page/main_top_4.png"),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: MainTopCard("assets/main_page/main_top_1.png"),
                ),
                Expanded(
                  flex: 5,
                  child: MainTopCard("assets/main_page/main_top_2.png"),
                ),
              ],
            ),
          ],
        ));
  }
}
