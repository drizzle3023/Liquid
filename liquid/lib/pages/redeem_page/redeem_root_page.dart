import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/pages/auth_page/signup_page/upload_avatar.dart';
import 'package:liquid/pages/auth_page/signup_page/signup_welcome_page.dart';
import 'package:liquid/pages/redeem_page/redeem_page.dart';

class RedeemRootPage extends StatefulWidget {
  RedeemRootPage({Key key}) : super(key: key);


  @override
  _RedeemRootPageState createState() => _RedeemRootPageState();
}

class _RedeemRootPageState extends State<RedeemRootPage> {

  Stream<FirebaseUser> _stream;
  final databaseReference =
  FirebaseDatabase.instance.reference().child("User");

  @override
  void initState() {
    _stream = FirebaseAuth.instance.onAuthStateChanged;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseUser>(
      stream: _stream,
      builder: (BuildContext context, authsnapshot) {
        if (authsnapshot.connectionState == ConnectionState.active) {

          if (authsnapshot.hasData) {

            return StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, snap) {
                if (snap.hasData &&
                    !snap.hasError &&
                    snap.data.snapshot.value != null) {
                  DataSnapshot snapshot = snap.data.snapshot;
                  dynamic user = {};

                  snapshot.value.forEach((key, value) {
                    if (key != null && value != null) {
                      if (value["uid"] == authsnapshot.data.uid) {
                        user = value;
                      }
                    }
                  });

                  if (user["isActive"] == true) {
                    return new RedeemPage();
                  } else if (user["isUploadedPhotos"] == true) {
                    return new SignUpWelcomePage();
                  } else {
                    return new UploadAvatarPage();
                  }
                }else {
                 // return SignInPage(venue: widget.venue,);
//                  return Container(
//                    color: Colors.white,
//                  );
                  return Center(child: CircularProgressIndicator());
                }
              },
            );

          } else {
            return SignInPage();
          }

        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}
