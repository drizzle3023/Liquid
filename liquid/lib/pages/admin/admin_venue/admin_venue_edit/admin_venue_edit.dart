import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid/models/Venue.dart';
import 'package:liquid/pages/admin/admin_map/admin_map.dart';
import 'package:liquid/utils/globals.dart';
import 'package:path/path.dart' as Path;
import 'package:toast/toast.dart';

class AdminVenueEdit extends StatefulWidget {

  final Venue venue;
  AdminVenueEdit({Key key, this.venue}) : super(key: key);

  @override
  _AdminVenueEditState createState() => _AdminVenueEditState();
}

class _AdminVenueEditState extends State<AdminVenueEdit> {

  bool _isLoading = false;

  FirebaseStorage _storage = FirebaseStorage.instance;
  final databaseReference = FirebaseDatabase.instance.reference().child("Venue/");

  final mainCategoryReference = FirebaseDatabase.instance.reference().child("Category");
  final subCategoryReference = FirebaseDatabase.instance.reference().child("SubCategory");
  TextStyle style = TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  LatLng newLocation;
  File _logoImage, _mainImage, _image1, _image2, _image3, _image4, _image5;
  List mainCategoryList = [];
  List subCategoryList = [];

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
          body: StreamBuilder(
              stream: mainCategoryReference.onValue,
              builder: (context, snap) {
                if (snap.hasData && !snap.hasError &&
                    snap.data.snapshot.value != null) {
                  DataSnapshot snapshot = snap.data.snapshot;

                  mainCategoryList.clear();
                  snapshot.value.forEach((key, value) {
                    if (key != null && value != null) {
                      mainCategoryList.add(value);
                    }
                  });

                  mainCategoryList.sort((a, b) {
                    return a["name"].toLowerCase().compareTo(b["name"].toLowerCase());
                  });

                  return StreamBuilder(
                      stream: subCategoryReference.onValue,
                      builder: (context, snap) {
                        if (snap.hasData && !snap.hasError &&
                            snap.data.snapshot.value != null) {
                          DataSnapshot snapshot = snap.data.snapshot;

                          subCategoryList.clear();
                          snapshot.value.forEach((key, value) {
                            if (key != null && value != null) {
                              subCategoryList.add(value);
                            }
                          });

                          subCategoryList.sort((a, b) {
                            return a["name"].toLowerCase().compareTo(b["name"].toLowerCase());
                          });

                          return Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "Edit venue",
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
                                                'name' : widget.venue.name,
                                                'mainCategory' : widget.venue.mainCategory.id,
                                                'subCategory' : widget.venue.subCategory.id,
                                                'location' : widget.venue.latitude + ',' + widget.venue.longitude,
                                                'address1' : widget.venue.address1,
                                                'address2' : widget.venue.address2,
                                                'address3' : widget.venue.address3,
                                                'zip' : widget.venue.zip,
                                                'city' : widget.venue.city,
                                                'country' : widget.venue.country,
                                                'email' : widget.venue.email,
                                                'phone' : widget.venue.phone,
                                                'website' : widget.venue.website,
                                                'facebookUrl' : widget.venue.facebookUrl,
                                                'instagramUrl' : widget.venue.instagramUrl,
                                                'youtubeUrl' : widget.venue.youtubeUrl,
                                                'twitterUrl' : widget.venue.twitterUrl,
                                                'openingHours' : widget.venue.openingHours,
                                                'about' : widget.venue.about,
                                                'logoImage' : widget.venue.logoImage,
                                                'mainImage' : widget.venue.mainImage,
                                                'image1' : widget.venue.image1,
                                                'image2' : widget.venue.image2,
                                                'image3' : widget.venue.image3,
                                                'image4' : widget.venue.image4,
                                                'image5' : widget.venue.image5,
                                                'discountBeverages' : widget.venue.discountBeverages,
                                                'discountFood' : widget.venue.discountFood,
                                                'discountOther' : widget.venue.discountOther,
                                                'redeem_pincode' : widget.venue.redeem_pincode,
                                                'isActive' : widget.venue.isActive
                                              },
                                              autovalidate: true,
                                              child: Column(
                                                children: <Widget>[
                                                  FormBuilderTextField(
                                                    attribute: "name",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "Venue Name:"),
                                                    validators: [
                                                      FormBuilderValidators.required(),
                                                    ],
                                                  ),
                                                  FormBuilderDropdown(
                                                    attribute: "mainCategory",
                                                    decoration: InputDecoration(labelText: "Choose main category:"),
                                                    hint: Text('Select main category'),
                                                    validators: [FormBuilderValidators.required()],
                                                    items: mainCategoryList
                                                        .map((category) => DropdownMenuItem(
                                                        value: category["id"],
                                                        child: Text(category["name"])
                                                    )).toList(),
                                                  ),
                                                  FormBuilderDropdown(
                                                    attribute: "subCategory",
                                                    decoration: InputDecoration(labelText: "Choose sub-category:"),
                                                    hint: Text('Select sub-category'),
                                                    validators: [FormBuilderValidators.required()],
                                                    items: subCategoryList
                                                        .map((category) => DropdownMenuItem(
                                                        value: category["id"],
                                                        child: Text(category["name"])
                                                    )).toList(),
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'location',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Set location on map:',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( newLocation == null ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to set location on the map", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: () async{
                                                              final result = await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => AdminMap(venue: widget.venue)),
                                                              );
                                                              if (result != null) {
                                                                setState(() {
                                                                  newLocation = result;
                                                                });
                                                                print(newLocation.latitude);
                                                                print(newLocation.longitude);
                                                              }
                                                            },
                                                            color: newLocation == null ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "address1",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "Address:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "address2",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "Address, additional info:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "address3",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "Hotel name, resort name:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "zip",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "ZIP code/post code:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "city",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "City:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "country",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "Country:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "email",
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: InputDecoration(labelText: "Email:"),
                                                    validators: [
                                                      FormBuilderValidators.email()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "phone",
                                                    keyboardType: TextInputType.phone,
                                                    decoration: InputDecoration(labelText: "Phone:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "website",
                                                    keyboardType: TextInputType.url,
                                                    decoration: InputDecoration(labelText: "Website URL:"),
                                                    validators: [
                                                      FormBuilderValidators.url()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "facebookUrl",
                                                    keyboardType: TextInputType.url,
                                                    decoration: InputDecoration(labelText: "FaceBook:"),
                                                    validators: [
                                                      FormBuilderValidators.url()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "instagramUrl",
                                                    keyboardType: TextInputType.url,
                                                    decoration: InputDecoration(labelText: "Instagram:"),
                                                    validators: [
                                                      FormBuilderValidators.url()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "youtubeUrl",
                                                    keyboardType: TextInputType.url,
                                                    decoration: InputDecoration(labelText: "Youtube:"),
                                                    validators: [
                                                      FormBuilderValidators.url()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "twitterUrl",
                                                    keyboardType: TextInputType.url,
                                                    decoration: InputDecoration(labelText: "Twitter:"),
                                                    validators: [
                                                      FormBuilderValidators.url()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "openingHours",
                                                    decoration: InputDecoration(labelText: "Opening hours:"),
                                                    maxLines: 4,
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "about",
                                                    textCapitalization: TextCapitalization.sentences,
                                                    decoration: InputDecoration(labelText: "About:"),
                                                    maxLines: 4,
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'logoImage',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Upload logo image: (max 1MB jpg/png)',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( _logoImage == null && widget.venue.logoImage == "" ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to select image file", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: (){
                                                              _openGallery(1);
                                                            },
                                                            color: _logoImage == null && widget.venue.logoImage == ""  ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'mainImage',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Upload main venue image: (max 1MB jpg/png)',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( _mainImage == null && widget.venue.mainImage == "" ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to select image file", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: (){
                                                              _openGallery(2);
                                                            },
                                                            color: _mainImage == null && widget.venue.mainImage == "" ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'image1',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Upload venue image1: (max 1MB jpg/png)',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( _image1 == null && widget.venue.image1 == ""  ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to select image file", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: (){
                                                              _openGallery(3);
                                                            },
                                                            color: _image1 == null && widget.venue.image1 == "" ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'image2',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Upload venue image2: (max 1MB jpg/png)',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( _image2 == null && widget.venue.image2 == "" ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to select image file", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: (){
                                                              _openGallery(4);
                                                            },
                                                            color: _image2 == null && widget.venue.image2 == "" ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'image3',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Upload venue image3: (max 1MB jpg/png)',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( _image3 == null && widget.venue.image3 == "" ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to select image file", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: (){
                                                              _openGallery(5);
                                                            },
                                                            color: _image3 == null && widget.venue.image3 == "" ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'image4',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Upload venue image4: (max 1MB jpg/png)',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( _image4 == null && widget.venue.image4 == "" ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to select image file", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: (){
                                                              _openGallery(6);
                                                            },
                                                            color: _image4 == null && widget.venue.image4 == "" ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderCustomField(
                                                    attribute: 'image5',
                                                    formField: FormField(
                                                      builder: (FormFieldState state) {
                                                        return InputDecorator(
                                                          decoration: InputDecoration(
                                                            labelText: 'Upload venue image5: (max 1MB jpg/png)',
                                                          ),
                                                          child: FlatButton(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon( _image5 == null && widget.venue.image5 == "" ? Icons.add : Icons.check, color: Colors.white, size: 18,),
                                                                Text("Click button to select image file", style: TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            onPressed: (){
                                                              _openGallery(7);
                                                            },
                                                            color: _image5 == null && widget.venue.image5 == "" ? Color(0xfff15a24) : Colors.lightGreen,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "discountBeverages",
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(labelText: "Discount, beverages:"),
                                                    validators: [
                                                      FormBuilderValidators.numeric()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "discountFood",
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(labelText: "Discount, food:"),
                                                    validators: [
                                                      FormBuilderValidators.numeric()
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "discountOther",
                                                    decoration: InputDecoration(labelText: "Discount, other:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderTextField(
                                                    attribute: "redeem_pincode",
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(labelText: "Unique PIN code for venue:"),
                                                    validators: [
                                                    ],
                                                  ),
                                                  FormBuilderSwitch(
                                                    label: Text('Status: (inactive/active)'),
                                                    attribute: "isActive",
                                                    initialValue: widget.venue.isActive,
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
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        );
  }

  _openGallery(int type) async {
    var gallery = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 1066,
        imageQuality: 88
    );
    print(gallery);

    setState(() {
      if (type == 1)
        this._logoImage = gallery;
      else if(type == 2)
        this._mainImage = gallery;
      else if(type == 3)
        this._image1 = gallery;
      else if(type == 4)
        this._image2 = gallery;
      else if(type == 5)
        this._image3 = gallery;
      else if(type == 6)
        this._image4 = gallery;
      else if(type == 7)
        this._image5 = gallery;
    });
  }

  void _submitForm() async {
    if (_fbKey.currentState.saveAndValidate()) {

      print(_fbKey.currentState.value);

      setState(() {
        _isLoading = true;
      });

      String logoImageUrl, mainImageUrl, image1Url, image2Url, image3Url, image4Url, image5Url;
      if (_logoImage != null) {
        String child1 = Globals.loginedUser.uid + "_logoImage_" + Path.basename(_logoImage.path);
        StorageReference storageReference = _storage.ref().child("VenueImages/").child("LogoImage/").child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_logoImage);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        logoImageUrl = (await downloadUrl.ref.getDownloadURL());
      }

      if (_mainImage != null) {
        String child1 = Globals.loginedUser.uid + "_mainImage_" + Path.basename(_mainImage.path);
        StorageReference storageReference = _storage.ref().child("VenueImages/").child("MainImage/").child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_mainImage);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        mainImageUrl = (await downloadUrl.ref.getDownloadURL());
      }

      if (_image1 != null) {
        String child1 = Globals.loginedUser.uid + "_image1_" + Path.basename(_image1.path);
        StorageReference storageReference = _storage.ref().child("VenueImages/").child("DetailImage/").child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_image1);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        image1Url = (await downloadUrl.ref.getDownloadURL());
      }

      if (_image2 != null) {
        String child1 = Globals.loginedUser.uid + "_image2_" + Path.basename(_image2.path);
        StorageReference storageReference = _storage.ref().child("VenueImages/").child("DetailImage/").child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_image2);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        image2Url = (await downloadUrl.ref.getDownloadURL());
      }

      if (_image3 != null) {
        String child1 = Globals.loginedUser.uid + "_image3_" + Path.basename(_image3.path);
        StorageReference storageReference = _storage.ref().child("VenueImages/").child("DetailImage/").child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_image3);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        image3Url = (await downloadUrl.ref.getDownloadURL());
      }

      if (_image4 != null) {
        String child1 = Globals.loginedUser.uid + "_image4_" + Path.basename(_image4.path);
        StorageReference storageReference = _storage.ref().child("VenueImages/").child("DetailImage/").child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_image4);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        image4Url = (await downloadUrl.ref.getDownloadURL());
      }

      if (_image5 != null) {
        String child1 = Globals.loginedUser.uid + "_image5_" + Path.basename(_image5.path);
        StorageReference storageReference = _storage.ref().child("VenueImages/").child("DetailImage/").child(child1);
        StorageUploadTask uploadTask = storageReference.putFile(_image5);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        image5Url = (await downloadUrl.ref.getDownloadURL());
      }

      Map<String, dynamic> updateClause = {};

      if (_logoImage != null) updateClause['logoImage'] = logoImageUrl;
      if (_mainImage != null) updateClause['mainImage'] = mainImageUrl;
      if (_image1 != null) updateClause['image1'] = image1Url;
      if (_image2 != null) updateClause['image2'] = image2Url;
      if (_image3 != null) updateClause['image3'] = image3Url;
      if (_image4 != null) updateClause['image4'] = image4Url;
      if (_image5 != null) updateClause['image5'] = image5Url;

      if (newLocation != null) {
        updateClause['latitude'] = newLocation.latitude.toString();
        updateClause['longitude'] = newLocation.longitude.toString();
      }

      updateClause['name'] = _fbKey.currentState.value['name'];
      updateClause['address1'] = _fbKey.currentState.value['address1'];
      updateClause['address2'] = _fbKey.currentState.value['address2'];
      updateClause['address3'] = _fbKey.currentState.value['address3'];
      updateClause['zip'] = _fbKey.currentState.value['zip'];
      updateClause['city'] = _fbKey.currentState.value['city'];
      updateClause['country'] = _fbKey.currentState.value['country'];
      updateClause['email'] = _fbKey.currentState.value['email'];
      updateClause['phone'] = _fbKey.currentState.value['phone'];
      updateClause['website'] = _fbKey.currentState.value['website'];
      updateClause['facebookUrl'] = _fbKey.currentState.value['facebookUrl'];
      updateClause['instagramUrl'] = _fbKey.currentState.value['instagramUrl'];
      updateClause['youtubeUrl'] = _fbKey.currentState.value['youtubeUrl'];
      updateClause['twitterUrl'] = _fbKey.currentState.value['twitterUrl'];
      updateClause['openingHours'] = _fbKey.currentState.value['openingHours'];
      updateClause['about'] = _fbKey.currentState.value['about'];
      updateClause['discountBeverages'] = _fbKey.currentState.value['discountBeverages'].toString();
      updateClause['discountFood'] = _fbKey.currentState.value['discountFood'].toString();
      updateClause['discountOther'] = _fbKey.currentState.value['discountOther'];
      updateClause['redeem_pincode'] = _fbKey.currentState.value['redeem_pincode'].toString();
      updateClause['isActive'] = _fbKey.currentState.value['isActive'];

      int mainCategoryId = _fbKey.currentState.value['mainCategory'];
      for (int i = 0; i < mainCategoryList.length; i ++) {
        if (mainCategoryList[i]["id"] == mainCategoryId) {
          updateClause['category'] = {
            'id' : mainCategoryId,
            'name' : mainCategoryList[i]["name"]
          };
          break;
        }
      }

      int subCategoryId = _fbKey.currentState.value['subCategory'];
      for (int i = 0; i < subCategoryList.length; i ++) {
        if (subCategoryList[i]["id"] == subCategoryId) {
          updateClause['subCategory'] = {
            'id' : subCategoryId,
            'name' : subCategoryList[i]["name"]
          };
          break;
        }
      }

      databaseReference.child(widget.venue.venueId).update(updateClause).then((val) {
        setState(() {
          _isLoading = false;
        });
        Globals.shared.showToast(
            context, "Successfully Updated this venue.",
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
      });

    }
  }
}
