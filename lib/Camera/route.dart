import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/ingre_name_list.dart';

// import 'package:yorizori_app/Login/login.dart';
// import 'package:yorizori_app/Login/register_page1.dart';
// import 'package:yorizori_app/Login/splash.dart';

// import 'package:yorizori_app/Login/test.dart';
// import 'package:yorizori_app/Login/register_page2.dart';

// import 'package:yorizori_app/main2.dart';

import './camera.dart';
import './alert.dart';

void main() => runApp(CameraRoute());

class CameraRoute extends StatefulWidget {
  CameraRoute({Key? key}) : super(key: key);

  @override
  _CameraRouteState createState() => _CameraRouteState();
}

class _CameraRouteState extends State<CameraRoute> {
  var _flag = 1;

  void _flag_update() {
    setState(() {
      _flag = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (route_flag.isEmpty == true && _flag == 1) {
      return MaterialApp(
        initialRoute: '/',
        title: 'Yorizori',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        debugShowCheckedModeBanner: false,
        home: CameraAlert(_flag_update),
        routes: {
          'camera': (context) => Camera(),
        },
      );
    } else {
      return MaterialApp(
        initialRoute: '/',
        title: 'Yorizori',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        debugShowCheckedModeBanner: false,
        home: Camera(),
        routes: {
          'camera': (context) => Camera(),
        },
      );
    }
  }
}
