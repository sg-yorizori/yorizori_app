import 'package:flutter/material.dart';

import 'package:yorizori_app/Login/login.dart';
import 'package:yorizori_app/Login/register_page1.dart';
import 'package:yorizori_app/Login/splash.dart';

import 'package:yorizori_app/Login/test.dart';
import 'package:yorizori_app/Login/register_page2.dart';

import 'package:yorizori_app/main2.dart';

void main() => runApp(YorizoriApp());

class YorizoriApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Yorizori',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        'register': (context) => MyRegister(),
        'login': (context) => MyLogin(),
        'splash': (context) => SplashScreen(),
        'mainpage': (context) => MyHomePage(title: 'Yorizori'),
        'register2': (context) => MyRegister_2(),
      },
    );
  }
}

class YorizoriAppAfterLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Yorizori',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: MyLogin(),
      routes: {
        'register': (context) => MyRegister(),
        'login': (context) => MyLogin(),
        'mainpage': (context) => MyHomePage(title: 'Yorizori'),
        'register2': (context) => MyRegister_2(),
      },
    );
  }
}
