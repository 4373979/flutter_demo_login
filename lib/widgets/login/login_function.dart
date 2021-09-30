import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/login_db.dart';
import 'package:flutter_demo_login/db/token_db.dart';
import 'package:flutter_demo_login/models/login_model.dart';
import 'package:flutter_demo_login/services/login_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);



Future<void> handleSignOut() async {
  _googleSignIn.signOut();
  _googleSignIn.disconnect();
}

Future<void> logout(BuildContext context) async {
  await LoginDb().logout()
      .then((value) => handleSignOut())
      .then((value) =>
      Navigator.pushReplacementNamed(
          context,
          "/login"));
}

List languageCode = ["en","zh"];
List countryCode = ["US","CN"];

void userLogin(BuildContext context,_formKey,username,password) {
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

void onActionSheetPress(BuildContext context) {
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
