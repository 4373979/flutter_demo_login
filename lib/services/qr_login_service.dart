import 'package:dio/dio.dart';
import 'package:flutter_demo_login/utils/apis.dart';
import 'package:flutter_demo_login/utils/config.dart';

class QrLoginService {
  Future<bool> qrLoginRequest(String uniqueId,String userToken) async {

    String serverIp = Constant.server_address;

    var options = BaseOptions(
      baseUrl: serverIp,
      headers: {"token":userToken},
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);
    Response response = await dio.post(MyApi.qr_login+"?uniqueId=$uniqueId");
    int? statusCode = response.statusCode;
    if(statusCode==200){
      return true;
    }else{
      return false;
    }
  }
}