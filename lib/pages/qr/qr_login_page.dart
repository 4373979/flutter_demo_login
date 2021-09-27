import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/qr_login_db.dart';
import 'package:flutter_demo_login/db/token_db.dart';
import 'package:flutter_demo_login/services/qr_login_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class QrLoginPage extends StatefulWidget {
  const QrLoginPage({Key? key}) : super(key: key);

  @override
  _QrLoginPageState createState() => _QrLoginPageState();
}

class _QrLoginPageState extends State<QrLoginPage> {
  String? uniqueId;
  String? userToken;

  Future<void> getQrLoginSave() async {
    uniqueId = await QrLoginDb().getQrLogin();
  }

  Future<void> getUserToken() async {
    userToken = await TokenDb().getToken();
  }

  @override
  void initState() {
    super.initState();
    getQrLoginSave();
    getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('title.scan_code_login'.tr(),
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black),tooltip: 'return_text'.tr(), onPressed: (){
          Navigator.pop(context);
        }),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 60),
            Image.network(
              "https://flutterchina.club/images/flutter-mark-square-100.png",
              width: 80,
              height: 80,
            ),
            SizedBox(height: 20),
            Text('trying_computer_browser_login'.tr()),
            SizedBox(height: 5),
            Text('confirm_yourself'.tr()),
            SizedBox(height: 30),
            MaterialButton(
              child: Text('confirm_login'.tr()),
              color: Colors.pink[300],
              textColor: Colors.white,
              minWidth: 200,
              onPressed: () {
                qrLogin();
                Navigator.pushNamed(
                    context,
                    "/home");
              },
            ),
            MaterialButton(
              child: Text('cancel'.tr()),
              color: Colors.white,
              textColor: Colors.black,
              minWidth: 150,
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    "/home");
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> qrLogin() async {
    bool flag = await QrLoginService().qrLoginRequest(uniqueId!,userToken!);
    await QrLoginDb().delQrLogin();
    if(flag){
      Fluttertoast.showToast(
          msg: 'web_login_successfully'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: 'web_login_failed'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}