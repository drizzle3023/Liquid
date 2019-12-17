
import 'package:firebase_database/firebase_database.dart';
import 'package:liquid/models/User.dart';
import 'package:liquid/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static final SharedPreferencesHelper shared = SharedPreferencesHelper();
  SharedPreferencesHelper() {}

  static final String _uid = "uid";
  final databaseReference = FirebaseDatabase.instance.reference().child("User");

  Future<String> getUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_uid) ?? '';
  }

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String uid = prefs.getString(_uid) ?? '';

    if (uid.length > 0) {
      databaseReference.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, value) {
          if (key != null && value != null) {
            if (value["uid"] == uid) {
              Globals.loginedUser = User.fromJson(value);
            }
          }
        });
      });
    }

  }

  static Future<void> setUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_uid, Globals.loginedUser.uid);
  }

  static Future<void> clearStoredData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(_uid);

  }
}