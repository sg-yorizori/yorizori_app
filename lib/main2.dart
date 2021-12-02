import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/camera.dart';
import 'package:yorizori_app/User/user_main.dart';
//import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/home.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/foundation.dart';

// void main_2() {
//   runApp(MyApp_2());
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List _title = ["YoriZori", "Camera", "User"];
  final List<Widget> _menu = [Home(), Camera(), UserPage()];

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
          new BottomNavigationBarItem(icon: Icon(Icons.home), label: _title[0]),
          new BottomNavigationBarItem(
              icon: Icon(Icons.camera), label: _title[1]),
          new BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: _title[2])
        ],
      ),
    );
  }
}
