import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_login/db/login_db.dart';
import 'package:flutter_demo_login/db/token_db.dart';
import 'package:flutter_demo_login/widgets/login/login_function.dart';
import 'package:flutter_demo_login/widgets/login/login_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String username = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  Future<void> checklogin(BuildContext context) async {
    String? token = await TokenDb().getToken();
    if(token!=null){
      logout(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // checklogin();
    handleSignOut();
  }

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
                    buildLoginButton(context,_formKey,username,password),
                    const SizedBox(height: 10),
                    buildSignUpButton(context),
                    const SizedBox(height: 30),
                    buildButtonGroup(context),
                  ]
              ),
            ),
          ),
        ),
      ),
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
}
