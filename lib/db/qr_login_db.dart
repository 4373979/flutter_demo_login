import 'package:shared_preferences/shared_preferences.dart';

class QrLoginDb {
  Future<void> setQrLogin(String uniqueId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('uniqueId', uniqueId);
  }

  Future<String?> getQrLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? uniqueId = sharedPreferences.getString('uniqueId');
    return uniqueId;
  }

  Future<void> delQrLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('uniqueId');
  }
}