import 'package:flutter/material.dart';

class MainTopCard extends StatelessWidget {
  final String imageUrl;

  const MainTopCard(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child:new Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),),
      ),
    );
  }
}
