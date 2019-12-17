import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:liquid/utils/globals.dart';
import 'package:toast/toast.dart';

class AdminStaticTextPrivacy extends StatefulWidget {

  AdminStaticTextPrivacy({Key key}) : super(key: key);

  @override
  _AdminStaticTextPrivacyState createState() => _AdminStaticTextPrivacyState();
}

class _AdminStaticTextPrivacyState extends State<AdminStaticTextPrivacy> {
  bool _isLoading = false;
  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final databaseReference = FirebaseDatabase.instance.reference().child("Privacy/");
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Privacy",
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

                          /*snapshot.value.forEach((key, value) {
                            if (key != null && value != null) {
                              _privacyString = value["text"].toString();
                            }
                          });
                           */
                          _privacyString = snapshot.value["text"];
                          return Column(
                            children: <Widget>[
                              Expanded(
                                  child: FormBuilder(
                                    key: _fbKey,
                                    initialValue: {
                                      'privacy': _privacyString
                                    },
                                    child: FormBuilderTextField(
                                      attribute: "privacy",
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(labelText: "Text:"),
                                      maxLines: 30,
                                      validators: [
                                      ],
                                    ),
                                  )
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

  void _submitForm() async {
    if (_fbKey.currentState.saveAndValidate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> updateClause = {};
      updateClause['text'] = _fbKey.currentState.value['privacy'];

      databaseReference.update(updateClause).then((val) {
        setState(() {
          _isLoading = false;
        });
        Globals.shared.showToast(
            context, "Successfully Updated the text.",
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    }
  }
}
