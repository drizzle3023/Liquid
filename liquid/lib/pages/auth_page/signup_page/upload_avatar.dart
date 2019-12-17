import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/pages/auth_page/signup_page/signup_welcome_page.dart';
import 'package:liquid/pages/auth_page/signup_page/upload_avatar_guideline.dart';
import 'package:liquid/utils/globals.dart';
import 'package:path/path.dart' as Path;
import 'package:speech_bubble/speech_bubble.dart';
import 'package:toast/toast.dart';

class UploadAvatarPage extends StatefulWidget {

  UploadAvatarPage({Key key})
      : super(key: key);

  @override
  _UploadAvatarPageState createState() => new _UploadAvatarPageState();
}

class _UploadAvatarPageState extends State<UploadAvatarPage> {
  FirebaseStorage _storage = FirebaseStorage.instance;
  final databaseReference =
      FirebaseDatabase.instance.reference().child("User/");

  TextStyle style =
      TextStyle(fontFamily: 'Helvetica', fontSize: 22.0, color: Colors.white);
  TextStyle smallStyle =
      TextStyle(fontFamily: 'Helvetica', fontSize: 15.0, color: Colors.white);
  bool _isLoading = false;
  bool _isTablet = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _avatar4Upload, _workID4Upload;

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = false;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    }

    Orientation orientation = MediaQuery.of(context).orientation;

    if ((orientation == Orientation.portrait &&
            MediaQuery.of(context).size.width <= 600) ||
        (orientation == Orientation.landscape &&
            MediaQuery.of(context).size.height <= 600)) {
      _isTablet = false;
    } else {
      _isTablet = true;
    }

    final uploadWorkIDButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: _workID4Upload == null ? Color(0xfff15a24) : Colors.lightGreen,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: this._isTablet
              ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
              : EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
          onPressed: () {
            _optionsDialogBox(1);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _workID4Upload == null
                  ? Icon(
                      Icons.add,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
              Text("Add work ID",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: this._isTablet ? 22 : 18)),
            ],
          )),
    );

    final uploadAvatarButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: _avatar4Upload == null ? Color(0xfff15a24) : Colors.lightGreen,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: this._isTablet
            ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
            : EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        onPressed: () {
          _optionsDialogBox(2);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _avatar4Upload == null
                ? Icon(
                    Icons.add,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
            Text("Take Selfie",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: this._isTablet ? 22 : 18)),
          ],
        ),
      ),
    );

    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xfff15a24),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: this._isTablet
            ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
            : EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        onPressed: () {
          _submitForm();
        },
        child: Text("Upload photos",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: this._isTablet ? 22 : 18)),
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/signup_background.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Text("Click here for ID and photo guidelines", style: TextStyle(color: Colors.white),),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploadAvatarGuidelinePage()));
                              },
                            ),
                            SizedBox(height: 20),
                            uploadWorkIDButton,
                            SizedBox(height: this._isTablet ? 20.0 : 10),
                            uploadAvatarButton,
                            SizedBox(
                              height: this._isTablet ? 35.0 : 30,
                            ),
                            _isLoading == false
                                ? signupButton
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            SizedBox(
                              height: this._isTablet ? 35.0 : 30,
                            ),
                            SpeechBubble(
                                nipLocation: NipLocation.LEFT,
                                width: MediaQuery.of(context).size.width - 102,
                                color: Colors.white,
                                borderRadius: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "* Why do you need my workID and my photo?", style: TextStyle(color: Color(0xfff15a24), fontStyle: FontStyle.italic),),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Because Liquid Hospitality Card is a membership card strictly for the hopitality industry and we also want to make sure \"you\" are you. Thanks for understanding.",
                                      style: TextStyle(height: 1.25),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    InkWell(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color(0xFFEC5778),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        //Navigator.of(context).pop();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                    )
                  ],
                )),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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
              )
            ],
          )),
    );
  }

  Future<void> _optionsDialogBox(int type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Take a picture'),
                    onTap: _openCamera(type),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('Select from gallery'),
                    onTap: _openGallery(type),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openCamera(int type) async {
    Navigator.pop(context);

    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 1066,
      imageQuality: 88
    );
    print(picture);
    setState(() {
      if (type == 1)
        this._workID4Upload = picture;
      else
        this._avatar4Upload = picture;
    });
  }

  _openGallery(int type) async {
    Navigator.pop(context);
    var gallery = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 1066,
      imageQuality: 88
    );
    print(gallery);

    setState(() {
      if (type == 1)
        this._workID4Upload = gallery;
      else
        this._avatar4Upload = gallery;
    });
  }

  _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    if (_workID4Upload == null || _avatar4Upload == null) {
      setState(() {
        _isLoading = false;
      });
      Globals.shared.showToast(
          context, "Please take photo of your workID and avatar.",
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      String child1 = Globals.loginedUser.uid + "_" + Path.basename(_workID4Upload.path);
      String child2 = Globals.loginedUser.uid + "_" + Path.basename(_avatar4Upload.path);
      StorageReference workIDReference =
          _storage.ref().child("WorkID/").child(child1);
      StorageReference avatarReference =
          _storage.ref().child("Avatar/").child(child2);

      StorageUploadTask uploadTask = workIDReference.putFile(_workID4Upload);
      StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      final String workIDUrl = (await downloadUrl.ref.getDownloadURL());

      uploadTask = avatarReference.putFile(_avatar4Upload);
      downloadUrl = (await uploadTask.onComplete);
      final String avatarUrl = (await downloadUrl.ref.getDownloadURL());

      databaseReference.child(Globals.loginedUser.userId).update({
        'photoAvatarUrl': avatarUrl,
        'photoEmploymentUrl': workIDUrl,
        'isUploadedPhotos': true
      }).then((val) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpWelcomePage()));
      });
    }
  }
}
