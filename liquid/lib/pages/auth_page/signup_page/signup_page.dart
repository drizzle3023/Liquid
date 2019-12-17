import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/User.dart';
import 'package:liquid/pages/auth_page/signin_page/signin_page.dart';
import 'package:liquid/pages/auth_page/signup_page/upload_avatar.dart';
import 'package:liquid/services/auth_helper.dart';
import 'package:liquid/utils/globals.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference =
  FirebaseDatabase.instance.reference().child("User");

  TextStyle style =
      TextStyle(fontFamily: 'Helvetica', fontSize: 22.0, color: Colors.white);
  TextStyle smallStyle =
      TextStyle(fontFamily: 'Helvetica', fontSize: 15.0, color: Colors.white);
  bool _isLoading = false;
  bool _isTablet = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _firstName;
  String _lastName;
  String _phone;
  String _email;
  String _password;

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

    final firstNameField = Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.white,
          accentColor: Colors.white),
      child: TextFormField(
        obscureText: false,
        textCapitalization: TextCapitalization.sentences,
        //style: isLargeScreen ? style : smallStyle,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            contentPadding: this._isTablet
                ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
                : EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "First Name",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        validator: (String value) {
          if (value.length < 3) {
            return 'First Name must be more than 2 character';
          } else
            return null;
        },
        onSaved: (String val) {
          _firstName = val;
        },
      ),
    );

    final lastNameField = Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.white,
          accentColor: Colors.white),
      child: TextFormField(
        obscureText: false,
        textCapitalization: TextCapitalization.sentences,
        //style: isLargeScreen ? style : smallStyle,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            contentPadding: this._isTablet
                ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
                : EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Last Name",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        validator: (value) {
          if (value.length < 3)
            return 'Last Name must be more than 2 charater';
          else
            return null;
        },
        onSaved: (String value) {
          _lastName = value;
        },
      ),
    );

    final phoneField = Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.white,
          accentColor: Colors.white),
      child: TextFormField(
        obscureText: false,
        //style: isLargeScreen ? style : smallStyle,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone_android,
              color: Colors.white,
            ),
            contentPadding: this._isTablet
                ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
                : EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Phone number",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value.length < 3)
            return 'Last Name must be more than 2 charater';
          else
            return null;
        },
        onSaved: (String value) {
          _phone = value;
        },
      ),
    );

    final emailField = Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.white,
          accentColor: Colors.white),
      child: TextFormField(
        obscureText: false,
        //style: isLargeScreen ? style : smallStyle,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            contentPadding: this._isTablet
                ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
                : EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            hintText: "Email",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value))
            return 'Enter Valid Email';
          else
            return null;
        },
        onSaved: (String val) {
          _email = val.trim();
        },
      ),
    );
    final passwordField = Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.white,
          accentColor: Colors.white),
      child: TextFormField(
        obscureText: true,
        //style: isLargeScreen ? style : smallStyle,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          contentPadding: this._isTablet
              ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
              : EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Password",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        validator: (value) {
          if (value.length < 6)
            return 'Password must be more than 6 charater';
          else
            return null;
        },
        onSaved: (String value) {
          _password = value;
        },
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
          _validateInputs();
        },
        child: Text("Sign Up",
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
                        autovalidate: _autoValidate,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            firstNameField,
                            SizedBox(height: this._isTablet ? 20.0 : 5),
                            lastNameField,
                            SizedBox(height: this._isTablet ? 20.0 : 5),
                            phoneField,
                            SizedBox(height: this._isTablet ? 20.0 : 5),
                            emailField,
                            SizedBox(height: this._isTablet ? 20.0 : 5),
                            passwordField,
                            SizedBox(
                              height: this._isTablet ? 35.0 : 20,
                            ),
                            _isLoading == false
                                ? signupButton
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
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

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState.save();
      FirebaseUser user;
      try {
        user = (await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        ))
            .user;
      } catch (e) {
        print(e.toString());
        String exception = Auth.getExceptionText(e);
        Globals.shared.showToast(context, exception, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } finally {
        if (user != null) {
          DatabaseReference newChild = databaseReference.push();
          User newUser = new User();
          newUser.userId = newChild.key;
          newUser.dateTime = ServerValue.timestamp;
          newUser.firstName = _firstName;
          newUser.lastName = _lastName;
          newUser.email = _email;
          newUser.password = _password;
          newUser.phone = _phone;
          newUser.uid = user.uid;
          newUser.memberSinceDate = ServerValue.timestamp;

          newChild.set(newUser.toJson()).then((val){
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UploadAvatarPage()));
          });

          //final smtpServer = gmail(Globals.gmailUser, Globals.gmailPassword);
          final smtpServer = SmtpServer(Globals.smtpServer, port: Globals.smtpPort, username: Globals.smtpUser, password: Globals.smtpPassword);

          // Create our message.
          final message = Message()
            ..from = Address(Globals.gmailUser, 'Liquid Admin')
            ..recipients.add(Globals.adminEmail)
            ..subject = 'New user Signed up'
            ..text = 'New User Signed Up.'
            ..html = "<h1>Please check your admin panel.</h1>\n<p> Name: " + _firstName + " " + _lastName + "</p>";

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

        } else {
          setState(() {
            _isLoading = false;
          });
          print("Error");
        }
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
