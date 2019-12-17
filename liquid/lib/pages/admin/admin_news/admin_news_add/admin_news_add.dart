import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:liquid/utils/globals.dart';
import 'dart:math';
import 'package:toast/toast.dart';

class AdminNewsAdd extends StatefulWidget {

  AdminNewsAdd({Key key}) : super(key: key);

  @override
  _AdminNewsAddState createState() => _AdminNewsAddState();
}

class _AdminNewsAddState extends State<AdminNewsAdd> {

  bool _isLoading = false;

  final databaseReference = FirebaseDatabase.instance.reference().child("News/");

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
      body:
        Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Add News",
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
                              autovalidate: true,
                              child: Column(
                                children: <Widget>[
                                  FormBuilderTextField(
                                    attribute: "title",
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(labelText: "Title:"),
                                    validators: [
                                      FormBuilderValidators.required(),
                                    ],
                                  ),
                                  FormBuilderTextField(
                                    attribute: "content",
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(labelText: "Content:"),
                                    maxLines: 10,
                                    validators: [
                                    ],
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
          )
    );
  }

  void _submitForm() async {
    if (_fbKey.currentState.saveAndValidate()) {

      print(_fbKey.currentState.value);

      setState(() {
        _isLoading = true;
      });

      DatabaseReference newChild = databaseReference.push();

      Map<String, dynamic> updateClause = {};

      updateClause['title'] = _fbKey.currentState.value['title'];
      updateClause['content'] = _fbKey.currentState.value['content'];
      updateClause['datetime'] = ServerValue.timestamp;
      updateClause['newsId'] = newChild.key;

      newChild.set(updateClause).then((val){
        setState(() {
          _isLoading = false;
        });
        Globals.shared.showToast(
            context, "Successfully Add News.",
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _fbKey.currentState.reset();
        Navigator.of(context).pop();
      });

    }
  }
}
