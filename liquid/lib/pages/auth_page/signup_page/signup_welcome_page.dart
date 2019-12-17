import 'package:flutter/material.dart';
import 'package:liquid/models/LoginState.dart';
import 'package:liquid/pages/navigation.dart';
import 'package:liquid/pages/venue_detail_page/venue_detail_page.dart';
import 'package:liquid/services/auth_helper.dart';
import 'package:liquid/services/shared_preferences_helper.dart';
import 'package:liquid/utils/globals.dart';
import 'package:provider/provider.dart';

class SignUpWelcomePage extends StatefulWidget {

  SignUpWelcomePage({Key key}) : super(key: key);

  @override
  _SignUpWelcomePageState createState() => _SignUpWelcomePageState();
}

class _SignUpWelcomePageState extends State<SignUpWelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
//      onWillPop: () => Navigator.of(context).pushNamedAndRemoveUntil(
//          '/main', (Route<dynamic> route) => false) ,
      child: Scaffold(
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
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Auth.signOut();
                  Provider.of<LoginState>(context).logout();
                  Globals.loginedUser = null;
                  SharedPreferencesHelper.clearStoredData();

//                Navigator.of(context).pushNamedAndRemoveUntil(
//                    '/main', (Route<dynamic> route) => false);
                  Navigator.of(context).pop();
                  if (Globals.selectedVenue != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VenueDetailPage()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationPage()));
                  }
                },
                child: new Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/signup_welcome.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Dear " + (Globals.loginedUser != null ? Globals.loginedUser.firstName : "") + ",", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("Thank you for signing up. \nPlease allow the Liquid team some time to verify your information and we will get back to you. \nHave a great day.\n\nWith regards,\n\nTeam Liquid", style: TextStyle(fontSize: 16, height: 1.25),)
                      ],
                    ),
                  )
              )
            ],
          )

      ),
    );
  }
}
