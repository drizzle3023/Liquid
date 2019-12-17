
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/pages/profile_page/profile_update_page.dart';
import 'package:liquid/utils/globals.dart';
import 'package:path/path.dart' as Path;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  FirebaseStorage _storage = FirebaseStorage.instance;
  TextStyle style1 =
      TextStyle(fontSize: 14, fontFamily: 'Helvetica', fontWeight: FontWeight.bold);
  TextStyle style2 =
  TextStyle(fontSize: 14, fontFamily: 'Helvetica');

  final logDatabaseReference =
      FirebaseDatabase.instance.reference().child("Log/");

  var date = new DateTime.fromMillisecondsSinceEpoch(Globals.loginedUser.memberSinceDate);
  var selfieUrl;

  @override
  void initState() {
    super.initState();
    selfieUrl = Globals.loginedUser.photoAvatarUrl;
  }

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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/main', (Route<dynamic> route) => false);
                },
              )),
          body: StreamBuilder(
              stream: logDatabaseReference.onValue,
              builder: (context, snap) {
                if (snap.hasData &&
                    !snap.hasError &&
                    snap.data.snapshot.value != null) {
                  DataSnapshot snapshot = snap.data.snapshot;
                  var logList = new List<Map<String, Object>>();
                  snapshot.value.forEach((key, value) {
                    if (key != null && value != null) {
                      var log = new Map<String, Object>();
                      log['dateTime'] = value['dateTime'];
                      log['venueName'] = value['venueName'];
                      log['venueDiscountBeverage'] = value['venueDiscountBeverage'];
                      log['venueDiscountFood'] = value['venueDiscountFood'];
                      logList.add(log);
                    }
                  });

                  return Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.camera_alt),
                                            Text("UPDATE\nSELFIE", style: TextStyle(fontSize: 12, fontFamily: 'Helvetica'), textAlign: TextAlign.center,),
                                          ],
                                        ),
                                        onTap: (){_openGallery(1);},
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: CircleAvatar(
                                              radius: 85.0,
                                              backgroundImage:
                                              NetworkImage(selfieUrl),
                                              backgroundColor: Colors.transparent,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(85)),
                                            border: Border.all(
                                                color: Colors.black, width: 2)),
                                            padding: EdgeInsets.all(2),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(Globals.loginedUser.firstName + Globals.loginedUser.lastName, style: TextStyle(fontSize: 20, fontFamily: 'Helvetica' ),),
                                          RaisedButton(
                                            child: Text("UPDATE PROFILE"),
                                            color:  Color(0xfff15a24),
                                            textColor: Colors.white,
                                            onPressed: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileUpdatePage(user:Globals.loginedUser)));
                                            },
                                          )
                                        ],
                                      )
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.contact_mail),
                                            Text("UPDATE\nWORK ID", style: TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                                          ],
                                        ),
                                        onTap: (){_openGallery(2);},
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Personal details", style: style1,),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text("Email", style: style2,)
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(Globals.loginedUser.email, style: style2,)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Text("Date of Birth", style: style2,)
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(Globals.loginedUser.birthday, style: style2,)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Text("Phone", style: style2,)
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(Globals.loginedUser.phone, style: style2,)
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Membership details", style: style1,),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Text("Member since", style: style2,)
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(new DateFormat('dd MMM yyyy').format(date), style: style2,)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Text("Work ID and photo", style: style2,)
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(Globals.loginedUser.isUploadedPhotos ?
                                            (Globals.loginedUser.isActive ? "Uploaded" : "Pending admin approval") :
                                              "Not uploaded yet", style: style2,)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Text("Status", style: style2,)
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(Globals.loginedUser.isActive ? "Active" : "Not active", style: style2,)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Text("Membership plan", style: style2,)
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(Globals.loginedUser.paymentPlan == 1 ? "Pay monthly" : "Pay annually", style: style2,)
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Discounts redeemed", style: style1,),
                                    SizedBox(height: 5,),
                                    Container(
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: logList.length,
                                        itemBuilder: (context, index) {
                                          var date1 = new DateTime.fromMillisecondsSinceEpoch((int.tryParse(logList[index]["dateTime"].toString()) ?? 0));
                                          return Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Text(new DateFormat('dd.MM.yyyy hh:mm a').format(date1))
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(logList[index]["venueName"] ?? "")
                                              )
                                            ],
                                          );

                                        },
                                      ),
                                    )
                                  ]
                                )
                              ],
                            ),
                          )),
                        ],
                      ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
        ),
      ],
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

    if (gallery != null) {
      if (type == 1) {
        String child = Globals.loginedUser.uid + "_" + Path.basename(gallery.path);
        StorageReference avatarReference =
        _storage.ref().child("Avatar/").child(child);
        StorageUploadTask uploadTask = avatarReference.putFile(gallery);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        final String avatarUrl = (await downloadUrl.ref.getDownloadURL());

        final databaseReference =
        FirebaseDatabase.instance.reference().child("User/");

        databaseReference.child(Globals.loginedUser.userId).update({
          'photoAvatarUrl': avatarUrl,
        }).then((val) {
          setState(() {
            Globals.loginedUser.photoAvatarUrl = avatarUrl;
            this.selfieUrl = avatarUrl;
          });
        });
      } else if (type == 2) {
        String child = Globals.loginedUser.uid + "_" + Path.basename(gallery.path);
        StorageReference workIDReference =
        _storage.ref().child("WorkID/").child(child);
        StorageUploadTask uploadTask = workIDReference.putFile(gallery);
        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        final String workIDUrl = (await downloadUrl.ref.getDownloadURL());

        final databaseReference =
        FirebaseDatabase.instance.reference().child("User/");

        databaseReference.child(Globals.loginedUser.userId).update({
          'photoEmploymentUrl': workIDUrl
        }).then((val) {
          Globals.loginedUser.photoEmploymentUrl = workIDUrl;
        });
      }
    }
  }

}
