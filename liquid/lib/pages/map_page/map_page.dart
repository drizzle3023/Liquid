import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/venue_detail_page/venue_detail_page.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Venue");

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.0779167, 55.1402500),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, snap) {
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            DataSnapshot snapshot = snap.data.snapshot;
            List item = [];

            snapshot.value.forEach((key, value) {
              if (key != null && value != null) item.add(value);
            });

            for(var i = 0; i < item.length; i ++) {
              final MarkerId markerId = MarkerId(item[i]["venueId"]);

              // creating a new MARKER
              final Marker marker = Marker(
                markerId: markerId,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                position: LatLng(
                  double.parse(item[i]["latitude"].toString()),
                  double.parse(item[i]["longitude"].toString()),
                ),
                infoWindow: InfoWindow(title: item[i]["name"],  onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VenueDetailPage(venue: Venue.fromJson(item[i]),)));
                }),
                onTap: () {
                  //_onMarkerTapped(markerId);
                },
              );
                // adding a new marker to map
                markers[markerId] = marker;
            }


            return GoogleMap(
              // mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(markers.values),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

}
