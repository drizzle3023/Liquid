
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class TermsPage extends StatefulWidget {

  TermsPage({Key key}) : super(key: key);

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  final databaseReference = FirebaseDatabase.instance.reference().child("Terms/");
  String _termsString;

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
                      "Terms & Conditions",
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

                          _termsString = snapshot.value["text"];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(_termsString, textAlign: TextAlign.left,),
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
