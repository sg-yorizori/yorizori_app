import 'package:flutter/material.dart';
import 'package:yorizori_app/Login/login.dart';
import 'package:yorizori_app/Login/register_page1.dart';
import 'package:yorizori_app/Login/splash.dart';

import 'package:yorizori_app/Login/test.dart';
import 'package:yorizori_app/Login/register_page2.dart';

import 'package:yorizori_app/main2.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'splash': (context) => SplashScreen(),
      'mainpage': (context) => MyApp_2(),
      'register2': (context) => MyRegister_2(),
    },
  ));
}