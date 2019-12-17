import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/LoginState.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/admin/admin_static_text/admin_static_text_privacy/admin_static_text_privacy.dart';
import 'package:liquid/pages/admin/admin_static_text/admin_static_text_terms/admin_static_text_terms.dart';
import 'package:liquid/pages/admin/admin_venue/admin_venue_add/admin_venue_add.dart';
import 'package:liquid/pages/admin/admin_venue/admin_venue_edit/admin_venue_edit.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/services/auth_helper.dart';
import 'package:liquid/services/shared_preferences_helper.dart';
import 'package:liquid/utils/globals.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RedeemPage extends StatefulWidget {

  RedeemPage({Key key}) : super(key: key);

  @override
  _RedeemPageState createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  bool _isLoading = false;
  final databaseReference = FirebaseDatabase.instance.reference().child("Log/");
  TextEditingController pinTEC = new TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "REDEEM",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 2,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("discount for", style: TextStyle(fontFamily: "SnellBT", fontSize: 60, color: Color(0xfff15a24)), textAlign: TextAlign.center,),
                        SizedBox(height: 5,),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    color: Color(0xfff15a24),
                                    height: 42,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(Globals.loginedUser.firstName + " " + Globals.loginedUser.lastName, style: TextStyle(fontSize: 20),),
                                    )
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Center(child: new Icon(Icons.error)),
                                    imageUrl: Globals.loginedUser.photoAvatarUrl,
                                    fit: BoxFit.cover,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 2)
                                  ),
                                  padding: EdgeInsets.all(2),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 200,
                                  child: Theme(
                                    data: ThemeData(
                                        primaryColor: Colors.black,
                                        hintColor: Colors.black,
                                        accentColor: Colors.black
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      controller: pinTEC,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                          hintText: "TYPE PIN",
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(Radius.circular(0)),
                                          )
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (String val) {
                                        //_email = val.trim();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 200,
                                  child: Material(
                                    color: Color(0xfff15a24),
                                    child: _isLoading == false ? MaterialButton(
                                      minWidth: 200,
                                      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                                      onPressed: () {
                                        _doRedeem();
                                      },
                                      child: Text("REDEEM ME", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    ) : Center(
                                      child: CircularProgressIndicator(),
                                  ),
                                )
                                )
                              ],
                            ),
                            ),
                          ),
                        )
                      ],
                    ),)
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  void _doRedeem() async {

    if (pinTEC.text == null || pinTEC.text.toString() == "") {
      Globals.shared.showToast(context, "Please Input PIN Code.", duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return ;
    }

    if (pinTEC.text != Globals.selectedVenue.redeem_pincode) {
      Globals.shared.showToast(context, "Wrong PIN, try again.", duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return ;
    } else {

      setState(() {
        _isLoading = true;
      });


      DatabaseReference newChild = databaseReference.push();

      Map<String, dynamic> addClause = {};

      addClause['logId'] = newChild.key;
      addClause['userId'] = Globals.loginedUser.userId;
      addClause['userUid'] = Globals.loginedUser.uid;
      addClause['venueId'] = Globals.selectedVenue.venueId;
      addClause['venueName'] = Globals.selectedVenue.name;
      addClause['venueDiscountBeverage'] = Globals.selectedVenue.discountBeverages;
      addClause['venueDiscountFood'] = Globals.selectedVenue.discountFood;
      addClause['ipAddress'] = "";
      addClause['browser'] = "";
      addClause['dateTime'] = ServerValue.timestamp;
      addClause['location'] = {
        "latitude" : Globals.selectedVenue.latitude,
        "longitude" : Globals.selectedVenue.longitude,
      };

      newChild.set(addClause).then((val){
        setState(() {
          _isLoading = false;
        });
        Globals.shared.showToast(context, "Success! Discount redeemed.", duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
      });

    }

  }
}
