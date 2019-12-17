import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid/models/LoginState.dart';
import 'package:liquid/models/User.dart';
import 'package:liquid/pages/admin/admin_dashboard/admin_dashboard.dart';
import 'package:liquid/pages/auth_page/reset_password_page/reset_password_page.dart';
import 'package:liquid/pages/auth_page/signup_page/signup_page.dart';
import 'package:liquid/pages/auth_page/signup_page/upload_avatar.dart';
import 'package:liquid/pages/auth_page/signup_page/signup_welcome_page.dart';
import 'package:liquid/pages/redeem_page/redeem_page.dart';
import 'package:liquid/services/auth_helper.dart';
import 'package:liquid/services/shared_preferences_helper.dart';
import 'package:liquid/utils/globals.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference().child("User");

  TextStyle style = TextStyle(fontFamily: 'Helvetica', fontSize: 22.0, color: Colors.white);
  TextStyle smallStyle = TextStyle(fontFamily: 'Helvetica', fontSize: 15.0, color: Colors.white);
  bool _isLoading = false;
  bool _isTablet = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
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

    final emailField = Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.white,
          accentColor: Colors.white
      ),
      child: TextFormField(
        obscureText: false,
        //style: isLargeScreen ? style : smallStyle,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.white,),
          contentPadding: this._isTablet
              ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
              : EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Email",
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.white),
          )
        ),
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
        accentColor: Colors.white
      ),
      child: TextFormField(
        obscureText: true,
        //style: isLargeScreen ? style : smallStyle,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.white,),
          contentPadding: this._isTablet
              ? EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
              : EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          hintText: "Password",
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.white),
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
    final loginButton = Material(
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
        child: Text("Sign In",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: this._isTablet ? 22 : 18)),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/signin_background.jpg'),
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Scaffold(
            resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
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
//                                isLargeScreen
//                                    ? SizedBox(height: 45.0)
//                                    : SizedBox(height: 85.0),
                                  emailField,
                                  SizedBox(height: this._isTablet ? 25.0 : 10),
                                  passwordField,
                                  SizedBox(
                                    height: this._isTablet ? 35.0 : 30,
                                  ),
                                  _isLoading == false
                                      ? loginButton
                                      : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  SizedBox(
                                    height: this._isTablet ? 25.0 : 20,
                                  ),
                                  InkWell(
                                    child: Text("Forgot password?", style: TextStyle(color: Colors.white, fontSize: 16,),),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPasswordPage()));
                                    },
                                  )
                                ],
                              ),
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
                      child: Text("SIGN IN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
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
                            Text("Don't have an account? ", style: TextStyle(color: Colors.white, fontSize: 16),),
                            InkWell(
                              child: Text("Sign Up", style: TextStyle(color: Color(0xFFEC5778), fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.underline),),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpPage()));
                              },
                            )
                          ],
                        )
                    ),
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
        ],
      )
    );
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables

    setState(() {
      this._isLoading = true;
    });

      _formKey.currentState.save();
      FirebaseUser user;
      try {
        user = (await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        )).user;
      } catch (e) {
        print(e.toString());
        String exception = Auth.getExceptionText(e);
        Globals.shared.showToast(context, exception, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } finally {
        if (user != null) {

          Provider.of<LoginState>(context).signin();

          databaseReference.once().then((DataSnapshot snapshot) {

            Map<dynamic, dynamic> values = snapshot.value;
            values.forEach((key,value) {
              if (key != null && value != null) {
                if (value["uid"] == user.uid) {
                  Globals.loginedUser = User.fromJson(value);
                }
              }
            });

            SharedPreferencesHelper.setUserData();
            setState(() {
              this._isLoading = false;
            });

            if (Globals.loginedUser.email == Globals.adminEmail) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AdminDashboard()));
            } else {
              Navigator.of(context).pop();
              if (Globals.loginedUser.isActive == true) {
                if (Globals.selectedVenue != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RedeemPage()));
                }
              } else if(Globals.loginedUser.isUploadedPhotos == true){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignUpWelcomePage()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UploadAvatarPage()));
              }
            }
          });

        } else {
          setState(() {
            this._isLoading = false;
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
