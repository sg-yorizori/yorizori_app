import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import './ingre.dart';
//import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/home.dart';

PickedFile? image_cam;

class Camera extends StatefulWidget {
  Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  // PickedFile? _image;
  int _flag1 = 0;
  int _flag2 = 1;

  Future getImageFromCam() async {
    var image =
    await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      image_cam = image!;
    });
  }

  Widget showImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Center(
        child: image_cam == null
            ? Text('No image selected!!')
            : Image.file(File(image_cam!.path)),
      ),
    );
  }

  void flag_update() {
    setState(() {
      _flag1 = 1;
    });
  }

  void _flag2_update() {
    setState(() {
      _flag2 = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_flag2 == 1) {
      if (_flag1 == 0) getImageFromCam();
      flag_update();

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ListViews',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          body: UsingBuilderListConstructing(_flag2_update),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: const Icon(Icons.navigation),
            backgroundColor: Colors.green,
          ),
        ),
      );
    }
    return Container();
  }
}
