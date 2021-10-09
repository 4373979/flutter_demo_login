import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_login/db/finger_db.dart';
import 'package:flutter_demo_login/pages/home/home_page.dart';
import 'package:flutter_demo_login/pages/login/login_page.dart';
import 'package:flutter_demo_login/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('zh', 'CN'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        saveLocale: true,
        child: MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;

  var localAuth = LocalAuthentication();

  bool flag = false;

  Future<void> flagCheck() async {

    bool flagBool = await FingerDb().getFinger();

    if(flagBool){
      bool canZhiwen = await localAuth.canCheckBiometrics;
      if(canZhiwen){
        const andStrings = const AndroidAuthMessages(
          cancelButton: '取消',
          goToSettingsButton: '去设置',
          goToSettingsDescription:'请设置指纹.',
          biometricHint: '指纹',
          biometricSuccess: '指纹识别成功',
          biometricNotRecognized: '指纹识别失败',
          signInTitle: '指纹登录',
          biometricRequiredTitle:'请先录入指纹!',
        );
        try{
          bool didAuthenticate = await localAuth.authenticate(//验证
              localizedReason:'扫描指纹进行身份识别',
              useErrorDialogs: false,
              androidAuthStrings: andStrings //汉化
          );
          print('didAuthenticate'+didAuthenticate.toString());
          if(didAuthenticate){
            setState(() {
              this.flag = flagBool;
            });
          }else{
            await FingerDb().setFinger(false);
          }
        }on PlatformException catch (e) {
          if (e.code == auth_error.notAvailable) {
            print('e.code：'+e.code);
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    flagCheck();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routes: routes(),
            initialRoute: flag?'/home':'/login2',
            // initialRoute: true?'/home':'/login',
          );
        }
    );
  }
}
