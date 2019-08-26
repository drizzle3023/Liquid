import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VenueDetailTopSlider extends StatelessWidget {
  final dynamic venue;
  VenueDetailTopSlider({this.venue});
  final List<String> images = ["mainImage", "image1", "image2", "image3", "image4", "image5"];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    //width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(3.0, 2, 3, 2),
                        child: InkWell(
                          child: Container(
                            child: Center(
                              child: CachedNetworkImage(
                                placeholder: (context, url) =>
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Center(
                                        child: new Icon(Icons.error)),
                                imageUrl: venue[images[index]] ??
                                    "",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      )
                  );
                })));
  }
}
