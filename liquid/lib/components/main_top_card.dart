import 'package:flutter/material.dart';

typedef Null ItemSelectedCallback();

class MainTopCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final ItemSelectedCallback onItemSelected;

  const MainTopCard({this.imageUrl, this.text, this.onItemSelected});

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
          child: InkWell(
            onTap: onItemSelected,
            child: Stack(
              children: <Widget>[
                new Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 0,
                  bottom: 18,
                  child: Container(
                    width: 500,
                    color: Color(0xFFF15A24).withOpacity(0.75),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(text, style: TextStyle(color: Colors.white),),
                    ),
                  ),
                )
              ],
            ),
          )
          ),
      ),
    );
  }
}
