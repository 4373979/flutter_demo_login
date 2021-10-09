import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_login/widgets/login/login_widgets.dart';
import 'package:ionicons/ionicons.dart';

class LoginPage3 extends StatefulWidget {
  const LoginPage3({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage3> {
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
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 730,
                  margin: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 120),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/login/logo-icon.png',
                            fit: BoxFit.fill,
                            width: 200,
                            height: 68,
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                  hintText: 'form.username'.tr(),
                                  labelText: 'form.username'.tr(),
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  hintMaxLines: 1,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Color(0xffB6B6B6), width: 1)
                                  )
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: 'form.password'.tr(),
                                  labelText: 'form.password'.tr(),
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  hintMaxLines: 1,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Color(0xffB6B6B6), width: 1)
                                  )
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(''),

                                Row(
                                  children: <Widget>[
                                    Icon(Ionicons.lock_closed,size: 16,),
                                    TextButton(
                                      onPressed: (){

                                      },
                                      child: Text("forget_password".tr(),style: const TextStyle(color: Colors.grey,fontSize: 16)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        // minWidth: 330,
                        minWidth: 290,
                        height: 45,
                        child: Text('button.login'.tr(),style: const TextStyle(color: Colors.white,fontSize: 20)),
                        color: Color.fromRGBO(48,129,56, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('do_not_have_an_account'.tr(),style: const TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: (){

                            },
                            child: Text("sign_up".tr(),style: const TextStyle(color: Colors.green,fontSize: 16)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('or_login_with'.tr(),style: const TextStyle(fontSize: 18,))
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 45.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(59,89,152, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Ionicons.logo_facebook),
                                    iconSize: 20,
                                    color: Colors.white,
                                    onPressed: (){
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            width: 50.0,
                            height: 45.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Ionicons.logo_apple),
                                    iconSize: 20,
                                    color: Colors.white,
                                    onPressed: (){
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            width: 50.0,
                            height: 45.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Ionicons.logo_google),
                                    iconSize: 20,
                                    color: Colors.white,
                                    onPressed: (){
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            width: 50.0,
                            height: 45.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(85,172,238, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Ionicons.logo_twitter),
                                    iconSize: 20,
                                    color: Colors.white,
                                    onPressed: (){
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              )
          ),
        ],
      ),
    );
  }

  BoxDecoration bulidDecorationImage(){
    return const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login/login-register.jpg'),
            fit: BoxFit.fill)
    );
  }
}


