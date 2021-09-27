import 'package:flutter/material.dart';
import 'package:flutter_demo_login/pages/home/home_page.dart';
import 'package:flutter_demo_login/pages/login/login_page.dart';
import 'package:flutter_demo_login/pages/qr/qr_page.dart';
import 'package:flutter_demo_login/pages/qr/qr_login_page.dart';


Map<String, WidgetBuilder> routes() {
  return {
    '/login': (context) => const LoginPage(),
    '/home': (context) => HomePage(),
    '/qrLogin': (context) => QrLoginPage(),
    '/qr': (context) => QrPage(),
  };
}
