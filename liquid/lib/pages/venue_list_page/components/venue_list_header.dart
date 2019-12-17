import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid/components/star_rating.dart';

class VenueListHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: Container(
                  child: RaisedButton(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Icon(Icons.sort, size: 12,),
                        new Text("ORDER BY NAME", style: TextStyle(fontSize: 12),)
                      ],
                    ),
                  ),
                ),
              )
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Container(
                    child: RaisedButton(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Icon(Icons.sort, size: 12,),
                          new Text("ORDER BY DISTANCE", style: TextStyle(fontSize: 12),)
                        ],
                      ),
                    ),
                  ),
                )
            ),
//            Expanded(
//                flex: 1,
//                child: Padding(
//                  padding: EdgeInsets.only(left: 2, right: 2),
//                  child: Container(
//                    child: RaisedButton(
//                      child: new Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          new Icon(Icons.filter_list, size: 12,),
//                          new Text("FILTER", style: TextStyle(fontSize: 12),)
//                        ],
//                      ),
//                    ),
//                  ),
//                )
//            ),
//            Expanded(
//                flex: 1,
//                child: Padding(
//                  padding: EdgeInsets.only(left: 2, right: 2),
//                  child: Container(
//                    child: RaisedButton(
//                      child: new Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          new Icon(Icons.search, size: 12,),
//                          new Text("SEARCH", style: TextStyle(fontSize: 12),)
//                        ],
//                      ),
//                    ),
//                  ),
//                )
//            ),

          ],
        )
    );
  }
}
