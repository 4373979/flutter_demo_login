import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/token_db.dart';
import 'package:flutter_demo_login/models/login_model.dart';
import 'package:flutter_demo_login/models/third_party_login_model.dart';
import 'package:flutter_demo_login/services/login_service.dart';
import 'package:flutter_demo_login/services/third_party_login_service.dart';
import 'package:ionicons/ionicons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String username = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: buildBody()
    );
  }

  Widget buildBody(){
    return Container(
      decoration: bulidDecorationImage(),
      child: Center(
        child: Container(
          decoration: bulidBoxDecorationBackgroundColor(),
          height: 530,
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Column(
                  children: <Widget>[
                    buildLogoImage(),
                    const SizedBox(height: 15),
                    buildUsernameField(),
                    const SizedBox(height: 10),
                    buildPasswordField(),
                    const SizedBox(height: 30),
                    buildLoginButton(context),
                    const SizedBox(height: 10),
                    buildSignUpButton(context),
                    const SizedBox(height: 30),
                    buildButtonGroup(),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context){
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: const Icon(Icons.language, color: Colors.white,size: 30,),
      onPressed: (){
        _onActionSheetPress(context);
      },
    );
  }

  BoxDecoration bulidDecorationImage(){
    return const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg-cover.jpg'),
            fit: BoxFit.fill)
    );
  }

  BoxDecoration bulidBoxDecorationBackgroundColor(){
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    );
  }

  Widget buildLogoImage(){
    return Expanded(
        child: Transform.scale(
            scale: 3.0,
            child: Image.asset('assets/images/login.png')
        )
    );
  }

  Widget buildButtonGroup(){
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize:MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Ionicons.logo_google),
              iconSize: 30,
              onPressed: (){
                signInWithGoogle();
              },
            ),
            IconButton(
              icon: const Icon(Ionicons.logo_apple),
              iconSize: 30,
              onPressed: (){
              },
            ),
            IconButton(
              icon: const Icon(Ionicons.logo_facebook),
              iconSize: 30,
              onPressed: (){
                signInWithFacebook();
              },
            ),
            IconButton(
              icon: const Icon(Ionicons.logo_twitter),
              iconSize: 30,
              onPressed: (){
              },
            )
          ],
        )
    );
  }

  Widget buildUsernameField(){
    return TextFormField(
      autofocus: true,
      // controller: _unameController,
      decoration: InputDecoration(
          hintText: 'form.username'.tr(),
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3.0))
      ),
      onChanged: (data){
        username=data;
        // print(data);
      },
      validator: (value) {
        if (value!.trim().length == 0) {
          return 'enter_valid_username'.tr();
        }
      }
    );
  }

  Widget buildPasswordField(){
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'form.password'.tr(),
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3.0))
      ),
      onChanged: (data){
        password=data;
        // print(data);
      },
      validator: (value) {
        if (value!.trim().length == 0) {
          return 'enter_valid_password'.tr();
        }
      },
    );
  }

  Widget buildLoginButton(BuildContext context){
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
        minimumSize:MaterialStateProperty.resolveWith((states) => const Size(double.infinity, 40)),
      ),
      child: const Text('button.login', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)).tr(),
      onPressed: (){
        userLogin();
      },
    );
  }

  Widget buildSignUpButton(BuildContext context){
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
        minimumSize:MaterialStateProperty.resolveWith((states) => const Size(double.infinity, 40)),
      ),
      child: const Text('button.signUp', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)).tr(),
      onPressed: (){},
    );
  }

  void userLogin() {
    if (_formKey.currentState!.validate()) {
      LoginModel loginModel = new LoginModel(username, password);
      UserService userService = new UserService();
      userService
          .loginRequest(loginModel)
          .then((token) =>TokenDb().setToken(token!)).then(
              (value) => Navigator.pushReplacementNamed(
              context,
              "/home"
          )).catchError((error) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('login_failed'.tr())));
      });
    }
  }

  List languageCode = ["en","zh"];
  List countryCode = ["US","CN"];

  void showDemoActionSheet({required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? i)
    {
      if(i != null) {
        EasyLocalization.of(context)!.setLocale(Locale(languageCode[int.parse(i)],countryCode[int.parse(i)]));
      }
    });
  }

  void _onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: const Text('language.selection.title').tr(),
        message: const Text('language.selection.message').tr(),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('language.name.en').tr(),
            onPressed: () => Navigator.pop(context, '0'),
          ),
          CupertinoActionSheetAction(
            child: const Text('language.name.zh').tr(),
            onPressed: () => Navigator.pop(context, '1'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('button.cancel').tr(),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
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

  UserCredential? userCredential;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    String idToken = googleAuth.idToken.toString();
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {
      this.userCredential=userCredential;
    });
    ThirdPartyLoginService thirdPartyLoginService = new ThirdPartyLoginService();
    ThirdPartyLoginModel thirdPartyLoginModel = new ThirdPartyLoginModel("Google",idToken);
    thirdPartyLoginService
        .loginRequest(thirdPartyLoginModel)
        .then((token) => TokenDb().setToken(token!)).then(
            (value) => Navigator.pushReplacementNamed(
                context,
                "/home"
            )).catchError((error) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('login_failed'.tr())));
    });
    return userCredential;
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      List<UserInfo> providerData = userCredential.user!.providerData;
      UserInfo providerData2 = providerData[0];
      String accessToken = providerData2.uid.toString()+"%2B"+credential.accessToken.toString();
      this.userCredential=userCredential;
      ThirdPartyLoginService thirdPartyLoginService = new ThirdPartyLoginService();
      ThirdPartyLoginModel thirdPartyLoginModel = new ThirdPartyLoginModel("FaceBook",accessToken);
      thirdPartyLoginService
          .loginRequest(thirdPartyLoginModel)
          .then((encoded) => TokenDb().setToken(encoded!)).then(
              (value) => Navigator.pushReplacementNamed(
                  context,
                  "/home"
              )).catchError((error) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('login_failed'.tr())));
      });
      return userCredential;
    }
    return null;
  }
}
