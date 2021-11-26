import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/camera.dart';
import 'package:yorizori_app/Keep/keep.dart';
//import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/home.dart';

import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primarySwatch: Colors.deepOrange,
      ),
      //home: Home(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List _title = ["YoriZori", "Camera", "Keep"];
  final List<Widget> _menu = [Home(), Camera(), Keep()];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(_title[_currentIndex]),
      ),*/
      body: _menu[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30.0), label: _title[0]),
          new BottomNavigationBarItem(
              icon: Icon(Icons.camera), label: _title[1]),
          new BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: _title[2])
        ],
      ),
    );
  }
}
