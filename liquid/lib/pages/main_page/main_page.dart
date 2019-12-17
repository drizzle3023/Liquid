
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:liquid/pages/closest_fb_page/closest_fb_page.dart';
import 'package:liquid/pages/closest_lifestyle_page/closest_lifestyle_page.dart';
import 'package:liquid/pages/main_page/components/cards_column.dart';
import 'package:liquid/pages/main_page/components/fb_venues_slider.dart';
import 'package:liquid/pages/main_page/components/lifestyle_locations_slider.dart';
import 'package:location/location.dart';

typedef Null IndutryNightsSelectedCallback();
class MainPage extends StatefulWidget {
  final IndutryNightsSelectedCallback onIndustryNightsSelected;
  MainPage({Key key, this.onIndustryNightsSelected}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var location = new Location();
  LocationData currentLocation;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return
      FutureBuilder (
        future: _getLocation(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Container();
          }
          return LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight - 100,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        MainTopCardColumn(onIndustryNightsSelected: widget.onIndustryNightsSelected,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                          child: Container(
                            height: 35,
                            color: Color(0xFFF15A24),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Closest F&B venues",
                                      style: TextStyle(color: Colors.white)),
                                  InkWell(
                                    child: Text("See all",
                                        style: TextStyle(color: Colors.white)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ClosestFBPage()));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        FBVenuesSlider(location: projectSnap.data,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                          child: Container(
                            height: 35,
                            color: Color(0xFFF15A24),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Closest Lifestyle locations",
                                      style: TextStyle(color: Colors.white)),
                                  InkWell(
                                    child: Text("See all",
                                        style: TextStyle(color: Colors.white)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ClosestLifestylePage()));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        LifeStyleLocationsSlider(location: projectSnap.data,),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );


  }

  _getLocation() async {
    return this._memoizer.runOnce(() async {
      var result = await location.getLocation();
      return result;
    });
  }

}
