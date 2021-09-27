import 'package:shared_preferences/shared_preferences.dart';

class FingerDb {
  Future<void> setFinger(bool flag) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('fingerFlag', flag.toString());
  }

  Future<bool> getFinger() async {
    bool flag;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? s = sharedPreferences.getString('fingerFlag');
    if(s=='true'){
      flag=true;
    }else{
      flag=false;
    }
    return flag;
  }
}