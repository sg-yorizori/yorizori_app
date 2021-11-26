import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

//import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/home.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import './ingrelist.dart';
import './addtile.dart';
import './bottom.dart';

PickedFile? image_cam;
List<IngreList> ingre_list = [];

class Camera extends StatefulWidget {
  Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  int _flag = 0;
  int _flag2 = 1;
  // List<IngreList> ingre_list = [];

  void _flag2_update() {
    setState(() {
      _flag2 = 1;
    });
  }

  Future _getImageFromCam() async {
    if (image_cam == null && _flag == 0) {
      var image =
          await ImagePicker.platform.pickImage(source: ImageSource.camera);
      print(image);
      // setState(() {
      if (image != null) image_cam = image!;
      // _flag = 1;
      // });
    }

    if (ingre_list.length == 0) {
      String data = await rootBundle.loadString('assets/ingre.json');
      final jsonData = json.decode(data);

      // List<IngreList> ingre_list = [];

      for (var i = 0; i < jsonData.length; i++) {
        IngreList ingre_one = IngreList(
          name: jsonData[i.toString()]["name"],
        );
        ingre_list.add(ingre_one);
      }
    }

    _flag = 1;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getImageFromCam(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (image_cam == null) {
              return Container(child: Center(child: Text("No image !!")));
            } else {
              return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(image_cam!.path)),
                        fit: BoxFit.cover),
                  ),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    body: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 250,

                          margin: EdgeInsets.only(
                              top: 320, bottom: 10, left: 5, right: 5),
                          // padding: EdgeInsets.only(
                          // top: MediaQuery.of(context).size.height * 0.5),
                          child: FutureBuilder(
                              future: _getImageFromCam(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return ListView.builder(
                                    padding: EdgeInsets.all(10),
                                    itemCount: ingre_list.length + 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == 0) {
                                        return TextButton(
                                          style: TextButton.styleFrom(

                                              // padding: EdgeInsets.all(10),
                                              textStyle:
                                                  const TextStyle(fontSize: 20),
                                              backgroundColor:
                                                  Colors.deepOrangeAccent,
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SecondRoute(
                                                            _flag2_update)),
                                              );
                                            });
                                          },
                                          child: const Text('재료 추가하기'),
                                        );
                                      }
                                      return ListTile(
                                          title:
                                              Text(ingre_list[index - 1].name),
                                          subtitle: Text("재료 삭제"),
                                          onTap: () {
                                            print(ingre_list.length);
                                            if (ingre_list.length != 1) {
                                              setState(() {
                                                ingre_list.removeWhere((item) =>
                                                    item.name ==
                                                    ingre_list[index - 1].name);
                                              });
                                            }
                                          });
                                    });
                              }),
                        ),
                      ],
                    ),
                  ));
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.deepOrangeAccent,
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 20,
          ),
          label: Text(
            "레시피 찾기",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
