
import 'package:flutter/cupertino.dart';

class LoginState extends ChangeNotifier {
  bool isLoggedIn = false;

  void signin() {
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }

}