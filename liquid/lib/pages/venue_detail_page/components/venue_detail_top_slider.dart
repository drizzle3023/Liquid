import 'package:flutter/material.dart';

class VenueDetailTopSlider extends StatelessWidget {
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
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
                                "assets/venue_detail/venue_detail_slider.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                  );
                })));
  }
}
