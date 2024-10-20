import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class Sharedprfs {
  static Future<void> init() async {}
static String?  getemail() {
    return prefs.getString('email');
  }
static String?  getpassword() {
    return prefs.getString('password');
  }

  // static String? email = getemail();
  // static String? password = prefs.getString('password');

  static setemail(String email) async {
    await prefs.setString('email', email);
  }

  static setpassword(String password) {
    prefs.setString('password', password);
  }

  static removeemailAndPassword() {
    print("delete from sharedprefs");
    prefs.remove('email');
    prefs.remove('password');
  }
}
