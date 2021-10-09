import 'package:flutter/material.dart';
import 'package:flutter_demo_login/pages/home/home_page.dart';
import 'package:flutter_demo_login/pages/login/login_page.dart';
import 'package:flutter_demo_login/pages/login/login_page2.dart';
import 'package:flutter_demo_login/pages/login/login_page3.dart';
import 'package:flutter_demo_login/pages/qr/qr_page.dart';
import 'package:flutter_demo_login/pages/qr/qr_login_page.dart';


Map<String, WidgetBuilder> routes() {
  return {
    '/login': (context) => const LoginPage(),
    '/login2': (context) => const LoginPage2(),
    '/login3': (context) => const LoginPage3(),
    '/home': (context) => HomePage(),
    '/qrLogin': (context) => QrLoginPage(),
    '/qr': (context) => QrPage(),
  };
}
