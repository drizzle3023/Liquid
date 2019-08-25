import 'package:flutter/material.dart';
import 'package:liquid/pages/venue_detail_page/venue_detail_page.dart';

class LifeStyleLocationsSlider extends StatelessWidget {
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return Container(
                    //width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(3.0, 2, 3, 2),
                        child: InkWell(
                          child: Container(
                            child: Center(
                              child: new Image.asset(
                                "assets/main_page/main_fb_slider.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VenueDetailPage()));
                          },
                        ),
                      )
                  );
                })));
  }
}
