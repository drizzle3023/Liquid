
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {

  HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  final databaseReference = FirebaseDatabase.instance.reference().child("FAQ/");
  String _privacyString;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
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
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Help and Support",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: StreamBuilder(
                      stream: databaseReference.onValue,
                      builder: (context, snap){

                        if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
                          DataSnapshot snapshot = snap.data.snapshot;

                          _privacyString = snapshot.value["text"];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(_privacyString, textAlign: TextAlign.left,),
                                )
                              ),
                            ],
                          );
                        }else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },

                    )
                  )
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

}
