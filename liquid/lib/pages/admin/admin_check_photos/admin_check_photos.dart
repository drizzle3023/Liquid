import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdminCheckPhotosPage extends StatefulWidget {
  final String imageUrl;

  AdminCheckPhotosPage({this.imageUrl});

  @override
  _AdminCheckPhotosPageState createState() => _AdminCheckPhotosPageState();
}

class _AdminCheckPhotosPageState extends State<AdminCheckPhotosPage> {

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 12, 12, 4),
                child: Card(
                    borderOnForeground: true,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            Center(child: new Icon(Icons.error)),
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                ),
              )
            ],
          ),
        )

      ),
    );
  }
}