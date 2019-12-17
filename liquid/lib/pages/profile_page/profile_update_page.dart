import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:liquid/models/User.dart';
import 'package:intl/intl.dart';
import 'package:liquid/pages/admin/admin_check_photos/admin_check_photos.dart';
import 'package:liquid/utils/globals.dart';
import 'package:liquid/utils/globals.dart' as prefix0;
import 'package:toast/toast.dart';

class ProfileUpdatePage extends StatefulWidget {

  final User user;
  ProfileUpdatePage({Key key, this.user}) : super(key: key);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {

  bool _isLoading = false;
  int _type = 0;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference().child("User/");

  TextStyle style = TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
          body: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Update Profile",
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  FormBuilder(
                                    key: _fbKey,
                                    initialValue: {
                                      'firstName' : widget.user.firstName,
                                      'lastName' : widget.user.lastName,
                                      'email' : widget.user.email,
                                      'phone' : widget.user.phone,
                                      //'password' : widget.user.password,
                                      'isUploadedPhotos' : widget.user.isUploadedPhotos,
                                      'isActive' : widget.user.isActive,
                                  },
                                    autovalidate: true,
                                    child: Column(
                                      children: <Widget>[
                                        FormBuilderTextField(
                                          attribute: "firstName",
                                          decoration: InputDecoration(labelText: "First Name:"),
                                          validators: [
                                            FormBuilderValidators.required(),
                                          ],
                                        ),
                                        FormBuilderTextField(
                                          attribute: "lastName",
                                          decoration: InputDecoration(labelText: "Last Name:"),
                                          validators: [
                                            FormBuilderValidators.required(),
                                          ],
                                        ),
                                        FormBuilderTextField(
                                          enabled: false,
                                          readOnly: true,
                                          attribute: "email",
                                          decoration: InputDecoration(labelText: "Email:"),
                                          validators: [
                                            FormBuilderValidators.email()
                                          ],
                                        ),
                                        FormBuilderTextField(
                                          attribute: "phone",
                                          decoration: InputDecoration(labelText: "Phone:"),
                                          validators: [
                                          ],
                                        ),
//                                        FormBuilderTextField(
//                                          attribute: "password",
//                                          enabled: false,
//                                          readOnly: true,
//                                          decoration: InputDecoration(labelText: "Password:"),
//                                          validators: [
//                                          ],
//                                        ),
                                        FormBuilderCustomField(
                                          attribute: 'membershipPlan',
                                          formField: FormField(
                                            builder: (FormFieldState state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                  labelText: 'Select Membership plan',
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    RaisedButton(
                                                      child: Padding(
                                                        padding: EdgeInsets.fromLTRB(8, 30, 8, 30),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text("Pay monthly", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                                            SizedBox(height: 8,),
                                                            Text("AED 10.99"),
                                                            Text("(per month)"),
                                                          ],
                                                        ),
                                                      ),
                                                      color: widget.user.paymentPlan == 1 && _type == 0 ?  Colors.lightGreen : (_type == 1 ? Colors.lightGreen : Color(0xfff15a24)),
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          _type = 1;
                                                        });
                                                      },
                                                    ),
                                                    RaisedButton(
                                                      child: Padding(
                                                        padding: EdgeInsets.fromLTRB(8, 30, 8, 30),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text("Pay annually", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                                            SizedBox(height: 8,),
                                                            Text("AED 99.99"),
                                                            Text("(save 25%)"),
                                                          ],
                                                        ),
                                                      ),
                                                      color: widget.user.paymentPlan == 2 && _type == 0 ?  Colors.lightGreen : (_type == 2 ? Colors.lightGreen : Color(0xfff15a24)),
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          _type = 2;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: _isLoading == false
                                              ? MaterialButton(
                                                  child: Text("Submit", style: TextStyle(color: Colors.white)),
                                                  onPressed: () {
                                                    _submitForm();
                                                  },
                                                  color: Color(0xfff15a24),
                                                )
                                              : Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: MaterialButton(
                                            child: Text("Reset", style: TextStyle(color: Colors.white),),
                                            onPressed: () {
                                              _isLoading == false ? _fbKey.currentState.reset() : (){};
                                            },
                                            color: Color(0xfff15a24),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          )
                      )
                    ],
                  ),
                ));

  }

  void _submitForm() async {
    if (_fbKey.currentState.saveAndValidate()) {

      print(_fbKey.currentState.value);

      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> updateClause = {};

      updateClause['firstName'] = _fbKey.currentState.value['firstName'];
      updateClause['lastName'] = _fbKey.currentState.value['lastName'];
      updateClause['phone'] = _fbKey.currentState.value['phone'];
      updateClause['paymentPlan'] = _type;

      databaseReference.child(widget.user.userId).update(updateClause).then((val) {
        setState(() {
          _isLoading = false;
        });
        Globals.loginedUser.firstName = updateClause['firstName'];
        Globals.loginedUser.lastName = updateClause['lastName'];
        Globals.loginedUser.phone = updateClause['phone'];
        Globals.loginedUser.paymentPlan = updateClause['paymentPlan'];

        Globals.shared.showToast(
            context, "Successfully Updated profile.",
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
      });

    }
  }
}
