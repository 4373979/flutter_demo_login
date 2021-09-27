import 'dart:convert';
import 'package:flutter_demo_login/models/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfoDb {
  Future<void> setUserInfo(String userInfoModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('userInfo', userInfoModel);
  }

  Future<UserInfoModel?> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userInfo = sharedPreferences.getString('userInfo');
    var userInfoJson = jsonDecode(userInfo!);
    UserInfoModel userInfoModel = UserInfoModel.fromJson(userInfoJson);
    return userInfoModel;
  }
}

