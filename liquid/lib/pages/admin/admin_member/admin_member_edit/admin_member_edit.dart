import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:liquid/models/User.dart';
import 'package:intl/intl.dart';
import 'package:liquid/pages/admin/admin_check_photos/admin_check_photos.dart';
import 'package:liquid/utils/globals.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:toast/toast.dart';

class AdminMemberEdit extends StatefulWidget {

  final User user;
  AdminMemberEdit({Key key, this.user}) : super(key: key);

  @override
  _AdminMemberEditState createState() => _AdminMemberEditState();
}

class _AdminMemberEditState extends State<AdminMemberEdit> {

  bool _isLoading = false;

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
                          "Edit/approve member",
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
                                      'memberSinceDate' : DateTime.fromMillisecondsSinceEpoch(widget.user.memberSinceDate)
                                  },
                                    autovalidate: true,
                                    child: Column(
                                      children: <Widget>[
                                        FormBuilderTextField(
                                          attribute: "firstName",
                                          textCapitalization: TextCapitalization.sentences,
                                          decoration: InputDecoration(labelText: "First Name:"),
                                          validators: [
                                            FormBuilderValidators.required(),
                                          ],
                                        ),
                                        FormBuilderTextField(
                                          attribute: "lastName",
                                          textCapitalization: TextCapitalization.sentences,
                                          decoration: InputDecoration(labelText: "Last Name:"),
                                          validators: [
                                            FormBuilderValidators.required(),
                                          ],
                                        ),
                                        FormBuilderTextField(
                                          enabled: false,
                                          readOnly: true,
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
//                                        FormBuilderTextField(
//                                          attribute: "password",
//                                          enabled: false,
//                                          readOnly: true,
//                                          decoration: InputDecoration(labelText: "Password:"),
//                                          validators: [
//                                          ],
//                                        ),
                                        FormBuilderCustomField(
                                          attribute: 'logoImage',
                                          formField: FormField(
                                            builder: (FormFieldState state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                  labelText: 'Click to view work ID:',
                                                ),
                                                child: FlatButton(
                                                  child: Text("Check work ID", style: TextStyle(color: Colors.white),),
                                                  onPressed: (){
                                                    if (widget.user.photoEmploymentUrl.length > 0) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => AdminCheckPhotosPage(imageUrl: widget.user.photoEmploymentUrl,)));
                                                    } else {
                                                      Globals.shared.showToast(
                                                          context, "This user didn't upload his work ID yet.",
                                                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                                    }
                                                  },
                                                  color: Color(0xfff15a24),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        FormBuilderCustomField(
                                          attribute: 'logoImage',
                                          formField: FormField(
                                            builder: (FormFieldState state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                  labelText: 'Click to view photo:',
                                                ),
                                                child: FlatButton(
                                                  child: Text("Check member selfie", style: TextStyle(color: Colors.white),),
                                                  onPressed: (){
                                                    if (widget.user.photoAvatarUrl.length > 0) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => AdminCheckPhotosPage(imageUrl: widget.user.photoAvatarUrl,)));

                                                    } else {
                                                      Globals.shared.showToast(
                                                          context, "This user didn't upload his photo yet.",
                                                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                                    }
                                                  },
                                                  color: Color(0xfff15a24),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        FormBuilderSwitch(
                                          label: Text('ID and photo approved: (inactive/active)'),
                                          attribute: "isUploadedPhotos",
                                          initialValue: widget.user.isUploadedPhotos,
                                        ),
                                        FormBuilderDateTimePicker(
                                          attribute: "memberSinceDate",
                                          inputType: InputType.date,
                                          format: DateFormat("yyyy-MM-dd"),
                                          decoration:
                                          InputDecoration(labelText: "Member since:"),
                                        ),
                                        FormBuilderTextField(
                                          attribute: "membershipPlan",
                                          decoration: InputDecoration(labelText: "Membership plan:"),
                                          validators: [
                                          ],
                                        ),
                                        FormBuilderSwitch(
                                          label: Text('Status: (inactive/active)'),
                                          attribute: "isActive",
                                          initialValue: widget.user.isActive,
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

      DateTime dateTime = DateTime.parse(_fbKey.currentState.value["memberSinceDate"].toString());
      updateClause['firstName'] = _fbKey.currentState.value['firstName'];
      updateClause['lastName'] = _fbKey.currentState.value['lastName'];
      updateClause['phone'] = _fbKey.currentState.value['phone'];
      updateClause['isUploadedPhotos'] = _fbKey.currentState.value['isUploadedPhotos'];
      updateClause['isActive'] = _fbKey.currentState.value['isActive'];
      updateClause['paymentPlan'] = _fbKey.currentState.value['membershipPlan'];
      updateClause['memberSinceDate'] = dateTime.millisecondsSinceEpoch;

      databaseReference.child(widget.user.userId).update(updateClause).then((val) async {

        final smtpServer = SmtpServer(Globals.smtpServer, port: Globals.smtpPort, username: Globals.smtpUser, password: Globals.smtpPassword);

        var content_text = "";

        if (widget.user.isUploadedPhotos != _fbKey.currentState.value['isUploadedPhotos']) {
          if (widget.user.isUploadedPhotos == false && _fbKey.currentState.value['isUploadedPhotos'] == true) {
            content_text = "Your ID and WorkID is approved.";
          } else if (widget.user.isUploadedPhotos == true && _fbKey.currentState.value['isUploadedPhotos'] == false){
            content_text = "Your ID and WorkID is denied.";
          }
          // Create our message.
          final message = Message()
            ..from = Address(Globals.gmailUser, 'Liquid Admin')
            ..recipients.add(widget.user.email)
            ..subject = 'Liquid News'
            ..text = content_text;

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          } finally {
//            setState(() {
//              this._isLoading = false;
//            });
          }
        }

        if (widget.user.isActive != _fbKey.currentState.value['isActive']) {
          if (widget.user.isActive == false && _fbKey.currentState.value['isActive'] == true) {
            content_text = "Your Account is approved.";
          } else if (widget.user.isActive == true && _fbKey.currentState.value['isActive'] == false){
            content_text = "Your Account is denied.";
          }
          // Create our message.
          final message = Message()
            ..from = Address(Globals.gmailUser, 'Liquid Admin')
            ..recipients.add(widget.user.email)
            ..subject = 'Liquid News'
            ..text = content_text;

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          } finally {
//            setState(() {
//              this._isLoading = false;
//            });
          }
        }

        setState(() {
          _isLoading = false;
        });
        Globals.shared.showToast(
            context, "Successfully Updated this member's information.",
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
      });

    }
  }
}
