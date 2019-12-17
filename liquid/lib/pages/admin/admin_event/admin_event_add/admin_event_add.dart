import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid/utils/globals.dart';
import 'package:path/path.dart' as Path;
import 'package:toast/toast.dart';

class AdminEventAdd extends StatefulWidget {
  AdminEventAdd({Key key}) : super(key: key);

  @override
  _AdminEventAddState createState() => _AdminEventAddState();
}

class _AdminEventAddState extends State<AdminEventAdd> {
  bool _isLoading = false;

  FirebaseStorage _storage = FirebaseStorage.instance;
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Event/");

  TextStyle style =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  File _image;

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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/main', (Route<dynamic> route) => false);
              },
            )),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "New Event",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderCustomField(
                          attribute: "name",
                          formField: FormField(builder: (FormFieldState state) {
                            return InkWell(
                              onTap: _optionsDialogBox,
                              child: DottedBorder(
                                color: Colors.grey[800],
                                strokeWidth: 2,
                                child: Container(
                                  child: SizedBox(
                                    height: 200,
                                    child: _image == null
                                        ? Center(
                                            child: Text('Tap to add image'))
                                        : Center(
                                            child: Image.file(
                                            _image,
                                            fit: BoxFit.cover,
                                          )),
                                  ),
                                ),
                              ),
                            );
                          }),
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
                                  child: Text("Submit",
                                      style: TextStyle(color: Colors.white)),
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
                    ],
                  )
                ],
              )))
            ],
          ),
        ));
  }

  Future<void> _optionsDialogBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Take a picture'),
                    onTap: _openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('Select from gallery'),
                    onTap: _openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openCamera() async {
    Navigator.pop(context);

    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    print(picture);
    setState(() {
      this._image = picture;
    });
  }

  _openGallery() async {
    Navigator.pop(context);
    var gallery = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 1066,
        imageQuality: 88);
    print(gallery);

    setState(() {
      this._image = gallery;
    });
  }

  void _submitForm() async {
    if (_fbKey.currentState.saveAndValidate()) {
      print(_fbKey.currentState.value);

      setState(() {
        _isLoading = true;
      });

      String imageUrl = '';
      if (_image != null) {
        String child1 =  new DateTime.now().millisecondsSinceEpoch.toString() +
            Path.basename(_image.path);
        StorageReference storageReference = _storage
            .ref()
            .child("Event/")
            .child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_image);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        imageUrl = (await downloadUrl.ref.getDownloadURL());
      }

      DatabaseReference newChild = databaseReference.push();

      Map<String, dynamic> updateClause = {};
      updateClause['image'] = imageUrl;
      updateClause['imageId'] = newChild.key;

      newChild.set(updateClause).then((val) {
        setState(() {
          _isLoading = false;
          _image = null;
        });
        Globals.shared.showToast(context, "Successfully Add new event.",
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
      });
    }
  }
}
