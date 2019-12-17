import 'package:flutter/widgets.dart';
import 'package:liquid/models/User.dart';
import 'package:liquid/models/Venue.dart';
import 'package:toast/toast.dart';

class Globals {
  static final Globals shared = Globals();

  Globals() {}

  static User loginedUser;
  static Venue selectedVenue;
  static final String adminEmail = "liquiddxbuae@gmail.com";
  static final String gmailUser = "welkomewebdev@gmail.com";
  static final String gmailPassword = "Welkomewebdev@2019";
  static final String smtpServer = "smtp-relay.sendinblue.com";
  static final int smtpPort = 587;
  static final String smtpUser = "enquiries@liquidcarduae.com";
  static final String smtpPassword = "4NzATWyxIGb9tPwL";

  //static String adminEmail = "jamesbrian0323@gmail.com";

  void showToast(BuildContext context, String msg,
      {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}