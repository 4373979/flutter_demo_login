import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_demo_login/db/user_info_db.dart';
import 'package:flutter_demo_login/models/login_model.dart';
import 'package:flutter_demo_login/models/public_key_model.dart';
import 'package:flutter_demo_login/utils/apis.dart';
import 'package:flutter_demo_login/utils/config.dart';
import 'package:jose/jose.dart';

class UserService {
  Future<String?> loginRequest(LoginModel loginModel) async {

    String serverIp = Constant.server_address;

    var options = BaseOptions(
      baseUrl: serverIp,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);
    Response response = await dio.post(MyApi.user_login+"?loginType=Simple", data: {
      "username": loginModel.username,
      "password": loginModel.password
    });
    String encoded = response.data;
    print("encoded:"+encoded);
    var jwt = new JsonWebToken.unverified(encoded);

    var keyData = await Dio().get(serverIp+MyApi.jwt_secret_key);
    var keyJson = jsonDecode(keyData.toString());
    PublicKeyModel publicKeyModel = PublicKeyModel.fromJson(keyJson);
    List keys = publicKeyModel.keys;
    var keyStore = new JsonWebKeyStore()
      ..addKey(new JsonWebKey.fromJson(keys[0]));

    bool verified = await jwt.verify(keyStore);
    JsonWebToken jsonWebToken = await JsonWebToken.decodeAndVerify(encoded, keyStore);
    Map<String, dynamic> violations = jsonWebToken.claims.toJson();
    if(verified){
      String userInfo = json.encode(violations);
      print("userInfo:"+userInfo);
      await UserInfoDb().setUserInfo(userInfo);
      return encoded;
    }else{
      return null;
    }
  }
}
