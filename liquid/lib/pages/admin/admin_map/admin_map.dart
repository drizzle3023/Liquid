import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liquid/models/Venue.dart';


class AdminMap extends StatefulWidget {

  final Venue venue;
  AdminMap({Key key, this.venue}) : super(key: key);

  @override
  _AdminMapState createState() => _AdminMapState();
}

class _AdminMapState extends State<AdminMap> {

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();

    if (widget.venue != null) {
      _kGooglePlex = CameraPosition(
          target: LatLng(double.parse(widget.venue.latitude),
              double.parse(widget.venue.longitude)),
          zoom: 14.4746
      );

      MarkerId markerId = MarkerId("_markerID1");
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          double.parse(widget.venue.latitude),
          double.parse(widget.venue.longitude),
        ),
        infoWindow: InfoWindow(title: "Original Place"),
        onTap: () {
          //_onMarkerTapped(markerId);
        },
      );
      markers[markerId] = marker;
    }
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
        body: GoogleMap(
         // mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (LatLng location) {
            _addMarker(longitude: location.longitude, latitude: location.latitude);
            showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Set location'),
                content: new Text('Do you want set location to this point?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, location);
                    },
                    child: new Text('Yes'),
                  ),
                ],
              ),
            );
          },
          markers: Set<Marker>.of(markers.values),
        ),
    );
  }

  void _addMarker({double latitude, double longitude}) {

    final MarkerId markerId = MarkerId(widget.venue != null ? widget.venue.venueId : "_newMarker");

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: LatLng(
        latitude,
        longitude,
      ),
      infoWindow: InfoWindow(title: widget.venue != null ? widget.venue.name : "New Venue Place", snippet: 'New place'),
      onTap: () {
        //_onMarkerTapped(markerId);
      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }
}
