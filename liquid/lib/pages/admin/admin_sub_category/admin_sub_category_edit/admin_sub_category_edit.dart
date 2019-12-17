import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:liquid/models/SubCategory.dart';
import 'package:liquid/utils/globals.dart';
import 'package:toast/toast.dart';

class AdminSubCategoryEdit extends StatefulWidget {

  final SubCategory category;
  AdminSubCategoryEdit({Key key, this.category}) : super(key: key);

  @override
  _AdminSubCategoryEditState createState() => _AdminSubCategoryEditState();
}

class _AdminSubCategoryEditState extends State<AdminSubCategoryEdit> {

  bool _isLoading = false;

  final databaseReference = FirebaseDatabase.instance.reference().child("SubCategory/");
  final venueDatabaseReference = FirebaseDatabase.instance.reference().child("Venue/");

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
                    "Edit Sub Category",
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
                                'name' : widget.category.name,
                              },
                              autovalidate: true,
                              child: Column(
                                children: <Widget>[
                                  FormBuilderTextField(
                                    attribute: "name",
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(labelText: "Category Name:"),
                                    validators: [
                                      FormBuilderValidators.required(),
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

      Map<String, dynamic> updateClause = {};

      updateClause['name'] = _fbKey.currentState.value['name'];

      databaseReference.child(widget.category.categoryId).update(updateClause).then((val) {

        venueDatabaseReference.once().then((DataSnapshot snapshot) {

          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key,value) {
            if (key != null && value != null) {
              if ((int.tryParse(value["subCategory"]["id"].toString()) ?? 0) == widget.category.id) {
                venueDatabaseReference.child(value["venueId"]).update({"subCategory" : {"id": widget.category.id, "name": updateClause["name"] }}).then((val) {
                });
              }
            }
          });

          setState(() {
            _isLoading = false;
          });
          Globals.shared.showToast(
              context, "Successfully Updated Sub category.",
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.of(context).pop();

        });

      });

    }
  }
}
