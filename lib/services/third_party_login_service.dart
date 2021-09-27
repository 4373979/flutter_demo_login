import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_demo_login/db/user_info_db.dart';
import 'package:flutter_demo_login/models/public_key_model.dart';
import 'package:flutter_demo_login/models/third_party_login_model.dart';
import 'package:flutter_demo_login/utils/apis.dart';
import 'package:flutter_demo_login/utils/config.dart';
import 'package:jose/jose.dart';

class ThirdPartyLoginService {
  Future<String?> loginRequest(ThirdPartyLoginModel thirdPartyLoginModel) async {

    String serverIp = Constant.server_address;

    var options = BaseOptions(
      baseUrl: serverIp,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);
    Response response = await dio.post(MyApi.user_login+"?loginType=${thirdPartyLoginModel.loginType}&loginToken=${thirdPartyLoginModel.loginToken}");
    String encoded = response.data;
    var jwt = JsonWebToken.unverified(encoded);

    var keyData = await Dio().get(Constant.login+MyApi.jwt_secret_key);
    var keyJson = jsonDecode(keyData.toString());
    PublicKeyModel publicKeyModel = PublicKeyModel.fromJson(keyJson);
    List keys = publicKeyModel.keys;
    var keyStore = JsonWebKeyStore()
      ..addKey(JsonWebKey.fromJson(keys[0]));

    bool verified = await jwt.verify(keyStore);
    // print(verified);
    JsonWebToken jsonWebToken = await JsonWebToken.decodeAndVerify(encoded, keyStore);
    Map<String, dynamic> violations = jsonWebToken.claims.toJson();
    if(verified){
      String userInfo = json.encode(violations);
      await UserInfoDb().setUserInfo(userInfo);
      return encoded;
    }else{
      return null;
    }
  }
}
