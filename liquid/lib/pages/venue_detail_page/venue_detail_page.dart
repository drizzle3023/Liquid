import 'package:flutter/material.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_contact.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_header.dart';
import 'package:liquid/pages/venue_detail_page/components/venue_detail_top_slider.dart';
import 'package:liquid/utils/globals.dart';

import 'components/venue_detail_redeem_button.dart';

class VenueDetailPage extends StatefulWidget {
  final Venue venue;
  VenueDetailPage({Key key, this.venue}) : super(key: key);

  @override
  _VenueDetailPageState createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {

  @override
  void initState() {
    super.initState();

    if (widget.venue != null) {
      Globals.selectedVenue = widget.venue;
    }
//    if (widget.venue == null || widget.venue["name"] == null) {
//      Navigator.of(context).pop();
//      Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) =>
//                  MainPage()));
//    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: InkWell(
          child: Container(
            height: 30,
            child: new Image.asset(
              "assets/appbar_logo.png",
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
          },
        )
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      VenueDetailHeader(venue: Globals.selectedVenue,),
                      VenueDetailTopSlider(venue: Globals.selectedVenue.toJson(),),
                      VenueDetailRedeemButton(venue: Globals.selectedVenue,),
                      VenueDetailContact(venue: Globals.selectedVenue,),
                      //VenueDetailBottomSlider(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: () {
//      //    Provider.of<LoginState>(context).signin();
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) =>
//                      RedeemRootPage()));
//        },
//        label: Text("Redeem"),
//        icon: Icon(Icons.thumb_up),
//        backgroundColor: Colors.pink,
//      ),

    );
  }
}
