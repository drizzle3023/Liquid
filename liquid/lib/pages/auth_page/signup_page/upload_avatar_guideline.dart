import 'dart:io';

import 'package:flutter/material.dart';

class UploadAvatarGuidelinePage extends StatefulWidget {

  UploadAvatarGuidelinePage({Key key})
      : super(key: key);

  @override
  _UploadAvatarGuidelinePageState createState() => new _UploadAvatarGuidelinePageState();
}

class _UploadAvatarGuidelinePageState extends State<UploadAvatarGuidelinePage> {

  TextStyle smallStyle =
      TextStyle(fontFamily: 'Helvetica', fontSize: 16.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = false;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    }

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
                padding: EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        child: Text(
                          "Your photo must meet the following criteria: \n\n"
                            "1. The photo must be in color with no filters. \n"
                        "2. The photo should only show head and shoulders like a passport photo.\n"
                        "3. Face the camera directly with full face in view.\n"
                        "4. Only one person should be in the photo.\n"
                        "5. No sunglasses or headwear.\n"
                        "6. The photo should be of the person applying for membership.\n"
                        "7. You must not wear headphones or wireless hands-free devices.\n\n"

                        "To be a member you must provide photographic evidence from the bar, beach club, beverage supplier, hotel, nightclub, restaurant or theme park where you are employed.\n\n"

                        "The following will be accepted as proof of employment:\n"
                        "1. Employment ID such as hotel card etc.\n"
                        "2. Business card with official email.\n"
                        "3. Salary certificate.\n"
                        "4. Bank statement showing proof of salary.\n"
                        "5. Letter on company letterhead confirming you work there.\n\n"
                        "Thank you,\n"
                        "Team Liquid\n",
                          style: smallStyle,
                        ),
                      ),
                    ),
                  ),
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
    );
  }

}
