import 'package:shared_preferences/shared_preferences.dart';

class TokenDb {
  Future<void> setToken(String userToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('userToken', userToken);
  }

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userToken = sharedPreferences.getString('userToken');
    return userToken;
  }
}

