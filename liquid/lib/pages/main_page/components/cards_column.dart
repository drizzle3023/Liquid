import 'package:flutter/material.dart';
import 'package:liquid/components/main_top_card.dart';
import 'package:liquid/pages/closest_fb_page/closest_fb_page.dart';
import 'package:liquid/pages/closest_lifestyle_page/closest_lifestyle_page.dart';
import 'package:liquid/pages/fb_20_30_page/fb_20_30_page.dart';
import 'package:liquid/pages/fb_35_50_page/fb_35_50_page.dart';

typedef Null IndutryNightsSelectedCallback();

class MainTopCardColumn extends StatelessWidget {
  final IndutryNightsSelectedCallback onIndustryNightsSelected;
  const MainTopCardColumn({this.onIndustryNightsSelected}) : super();

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
                  child: MainTopCard(imageUrl: "assets/main_page/main_top_1.png", text: "F&B 20-30% off", onItemSelected: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FB_20_30Page()));
                  },),
                ),
                Expanded(
                  flex: 5,
                  child: MainTopCard(imageUrl: "assets/main_page/main_top_2.png", text: "F&B 35-50% off", onItemSelected: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FB_35_50Page()));
                  },),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: MainTopCard(imageUrl: "assets/main_page/main_top_3.png", text: "Industry nights", onItemSelected: onIndustryNightsSelected),
                ),
                Expanded(
                  flex: 5,
                  child: MainTopCard(imageUrl: "assets/main_page/main_top_4.png", text: "Lifestyle", onItemSelected: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ClosestLifestylePage()));
                  },),
                ),
              ],
            ),
          ],
        ));
  }
}
