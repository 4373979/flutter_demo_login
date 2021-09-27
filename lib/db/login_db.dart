import 'package:flutter_demo_login/db/finger_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDb {
  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await FingerDb().setFinger(false);
    sharedPreferences.remove('userInfo');
    sharedPreferences.remove('userToken');
  }
}