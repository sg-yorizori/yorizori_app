import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:io' as Io;
import 'package:image_picker/image_picker.dart';
import 'package:yorizori_app/Camera/result_page.dart';

//import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/home.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';

import './addtile.dart';

import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import './ingre_name_list.dart';

PickedFile? image_cam;

var decodedBytes;

class Camera extends StatefulWidget {
  Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  int _flag = 0;
  int _flag2 = 1;

  void _flag2_update() {
    setState(() {
      _flag2 = 1;
    });
  }

  Future _getImageFromCam() async {
    if (image_cam == null && _flag == 0) {
      var image =
          await ImagePicker.platform.pickImage(source: ImageSource.camera);
      // await ImagePicker.platform.pickImage(source: ImageSource.gallery);

      if (image != null) {
        image_cam = image;

        // important!!
        final bytes = await Io.File(image_cam!.path).readAsBytes();

        String img64 = base64Encode(bytes);
        print(img64.substring(0, 100));

        final response = await http.post(
          Uri.parse(UrlPrefix.urls + "recipe/detect/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"image": img64}),
        );

        if (response.statusCode == 200) {
          // final data = json.decode(response.body);
          final data = jsonDecode(utf8.decode(response.bodyBytes));
          if (data != null && mounted) {
            print("camera success");

            String rlt_img = data['result'];

            decodedBytes = base64Decode(rlt_img);

            ingre_name_list = [];
            for (var i = 0; i < data['ingrd'].length; i++) {
              ingre_name_list.add(data['ingrd'][i]['name']);
            }
            print(ingre_name_list);
          }
        } else {
          print("camera fail");
          print(response.body);
        }
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
            if (_flag == 0) {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            } else if (image_cam == null) {
              return Container(child: Center(child: Text("No image !!")));
            } else {
              return Container(
                  child: Stack(children: [
                Container(
                  // margin: EdgeInsets.all(0),
                  height: 5000,
                  child: Image.memory(decodedBytes, fit: BoxFit.fill),
                ),
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      image: AssetImage('assets/images/red_background.png'),
                    ),
                  ),
                  height: 250,
                  margin:
                      EdgeInsets.only(top: 365, bottom: 10, left: 5, right: 5),
                  child: FutureBuilder(
                      future: _getImageFromCam(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: ingre_name_list.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return TextButton(
                                  style: TextButton.styleFrom(

                                      // padding: EdgeInsets.all(10),
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      backgroundColor: Colors.deepOrangeAccent,
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecondRoute(_flag2_update)),
                                      );
                                    });
                                  },
                                  child: const Text('재료 추가하기'),
                                );
                              }
                              return Card(
                                  color: Color(0xfff7caac),
                                  child: ListTile(
                                      leading: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      trailing: Icon(
                                        Icons.backspace_rounded,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      title: Text(
                                        ingre_name_list[index - 1],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      onTap: () {
                                        print(ingre_name_list.length);
                                        if (ingre_name_list.length != 1) {
                                          setState(() {
                                            ingre_name_list.removeWhere(
                                                (item) =>
                                                    item.compareTo(
                                                        ingre_name_list[
                                                            index - 1]) ==
                                                    0);
                                          });
                                        }
                                      }));
                            });
                      }),
                ),
                Align(
                  alignment: Alignment(-0.9, 0.96),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: Size(0, 50),
                      primary: Colors.deepOrangeAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        ingre_name_list = [];
                        _flag = 0;
                        image_cam = null;
                      });
                    },
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ]));
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // print("ingre_name_list");
            // print(ingre_name_list);
            if (ingre_name_list.isEmpty == true) return;
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultPage(_flag2_update)),
              );
            });
          },
          backgroundColor: Colors.deepOrangeAccent,
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 25,
          ),
          label: Text(
            "레시피 찾기",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
