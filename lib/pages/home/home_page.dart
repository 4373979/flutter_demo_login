import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/finger_db.dart';
import 'package:flutter_demo_login/db/login_db.dart';
import 'package:flutter_demo_login/db/user_info_db.dart';
import 'package:flutter_demo_login/models/user_info_model.dart';
import 'package:flutter_demo_login/widgets/home/home_drawer.dart';
import 'package:flutter_demo_login/widgets/home/home_menu_botton.dart';
import 'package:local_auth/local_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final LoginDb loginDb= new LoginDb();
  bool flag = false;
  UserInfoModel? userInfoModel;

  Future<void> getLoginUser() async {
    UserInfoModel? userInfoModel = await UserInfoDb().getUserInfo();
    setState(() {
      this.userInfoModel=userInfoModel;
    });
  }

  @override
  initState() {
    super.initState();
    flagCheck();
    getLoginUser();
  }

  @override
  Widget build(BuildContext context) {

    var localAuth = LocalAuthentication();

    return Scaffold(
      appBar: AppBar(
        title: Text('title.home'.tr()),
        centerTitle: true,
        //左侧按钮图标
        leading: MenuBotton(),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.qr_code_scanner),tooltip: 'qr_code_scanning'.tr(), onPressed: (){
            Navigator.pushReplacementNamed(
                context,
                "/qr");
            // _scan();
          }),
          IconButton(icon: Icon(Icons.logout),tooltip: 'log_out'.tr(), onPressed: (){
            logout();
          }),
        ],
      ),
      drawer: HomeDrawer(userInfoModel: userInfoModel),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('fingerprint_login'.tr()+"${this.flag == true ? 'enabled'.tr() : 'disabled'.tr()}"),
            Switch(
              value: this.flag,
              activeColor: Colors.blue,
              onChanged: (value) async {
                if(!this.flag){
                  try{
                    bool canZhiwen = await localAuth.canCheckBiometrics;
                    if(canZhiwen){
                      // const andStrings = const AndroidAuthMessages(
                      //   cancelButton: '取消',
                      //   goToSettingsButton: '去设置',
                      //   goToSettingsDescription:'请设置指纹.',
                      //   biometricHint: '指纹',
                      //   biometricSuccess: '指纹识别成功',
                      //   biometricNotRecognized: '指纹识别失败',
                      //   signInTitle: '指纹验证',
                      //   biometricRequiredTitle:'请先录入指纹!',
                      // );
                      bool didAuthenticate = await localAuth.authenticate(//验证
                          localizedReason: 'scan_fingerprint'.tr(),
                          useErrorDialogs: false,
                          // androidAuthStrings: andStrings //汉化
                      );
                      print(didAuthenticate);
                      if(didAuthenticate){
                        await FingerDb().setFinger(value);
                        setState(() {
                          this.flag = value;
                        });
                      }
                    }
                  }catch(e){
                    print(e);
                  }
                }else{
                  await FingerDb().setFinger(value);
                  setState(() {
                    this.flag = value;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Future<void> logout() async {
    await LoginDb().logout()
        .then((value) => _handleSignOut())
        .then((value) =>
        Navigator.pushReplacementNamed(
            context,
            "/login"));
  }

  Future<void> flagCheck() async {
    bool flagBool = await FingerDb().getFinger();
    setState(() {
      this.flag=flagBool;
    });
  }
}


