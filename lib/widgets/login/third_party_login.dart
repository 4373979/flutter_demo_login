import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/token_db.dart';
import 'package:flutter_demo_login/models/third_party_login_model.dart';
import 'package:flutter_demo_login/services/third_party_login_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

UserCredential? userCredential;

Future<void> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  String idToken = googleAuth.idToken.toString();
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
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
}

Future<void> signInWithFacebook(BuildContext context) async {
  final LoginResult result = await FacebookAuth.instance.login();
  if(result.status == LoginStatus.success){
    final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    List<UserInfo> providerData = userCredential.user!.providerData;
    UserInfo providerData2 = providerData[0];
    String accessToken = providerData2.uid.toString()+"%2B"+credential.accessToken.toString();
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
  }else{
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('login_failed'.tr())));
  }
}