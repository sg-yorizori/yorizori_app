import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yorizori_app/Camera/models/Recipe_one.dart';
import 'package:yorizori_app/Camera/models/unit.dart';
import 'package:yorizori_app/Camera/route.dart';
import 'package:yorizori_app/Home/AddRecipe/saveStepIMG.dart';
import 'package:yorizori_app/Home/textStyle.dart';
import 'package:yorizori_app/sharedpref.dart';
import 'package:yorizori_app/Home/models/addRecipeList.dart';
import 'package:yorizori_app/Home/AddRecipe/saveMainImage.dart';
import 'package:yorizori_app/Home/models/Add_Step_Detail.dart';

import 'dart:io' as Io;
import 'dart:io';

import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../home.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  var id;
  var title = TextEditingController();
  var thumb;

  final ingrd_name = TextEditingController();
  final ingrd_amount = TextEditingController();
  List<Unit> ingrd_list = [];

  var step_img;
  var step_contents = TextEditingController();
  var num = 1;
  List<Add_Step_Detail> step_list = [];

  main_img_setter(img) {
    thumb = img;
  }

  step_img_setter(img) {
    step_img = img;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    double width = screenSize.width;
    double height = screenSize.height;


    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,

        title: Text(
            "나의 레시피 추가하기",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, //Color(0xffFA4A0C),
            )
        ),
        centerTitle: true,

        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white, //Color(0xffFA4A0C),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: 20,
            ),
            Container(
              child:
              buildTextTitleVariation2('요리 제목과 메인 사진', false),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
              color: Color(0xfffa4a0c),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 1.5,
          ),

          SizedBox(
            height: 10,
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Container(
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "요리 이름",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                    controller: title,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          // thumb 사진 추가
          new pickMainImage(main_img_setter: main_img_setter),

          SizedBox(
            height: 20,
          ),


          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: 20,
            ),
            Container(
              child:
              buildTextTitleVariation2('조리 재료', false),
            ),
          ]),

          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
              color: Color(0xfffa4a0c),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 1.5,
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),

              SizedBox(
                width: 140,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "재료",
                      hintStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  controller: ingrd_name,
                ),
              ),

              SizedBox(
                width: 10,
              ),

              SizedBox(
                width: 140,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "계량",
                      hintStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  controller: ingrd_amount,
                ),
              ),

              SizedBox(width: 15),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(0, 40),
                  //primary: Color(0xfffa4a0c),
                ),
                onPressed: () {
                  setState(() {
                    if ((ingrd_name.text.isEmpty ||
                        ingrd_amount.text.isEmpty) == true) return;

                    for (var i = 0; i < ingrd_list.length; i++) {
                      if (ingrd_list[i].ingrd_name.compareTo(ingrd_name.text) ==
                          0) {
                        return;
                      }
                    }

                    ingrd_list.add(Unit(ingrd_amount.text, ingrd_name.text));
                  });
                },
                child: Text(
                  '추가',
                  style: TextStyle(
                    color: Colors.white,
                    //fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),

            ],
          ),

          SizedBox(
            height: 5,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            height: height * 0.07,
            child: FutureBuilder(
                future: _get_ingrd_input(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView(
                    padding: EdgeInsets.only(left: 2, bottom: 5, top: 5),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: buildIngrds(ingrd_list),
                  );
                }

            ),
          ),

          SizedBox(
            height: 10,
          ),

          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: 20,
            ),
            Container(
              child:
              buildTextTitleVariation2('요리 순서', false),
            ),
          ]),

          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
              color: Color(0xfffa4a0c),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 1.5,
          ),

          SizedBox(
            height: 10,
          ),


          // step 추가
          Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [kBoxShadow],
              ),
              child: Row(
                children: [

                  new pickStepImage(step_img_setter: step_img_setter),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          buildRecipeTitle("STEP " + num.toString()),

                          SizedBox(
                            width: 180,
                            height: 50,
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "요리 내용",
                                  hintStyle: TextStyle(fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              controller: step_contents,
                            ),
                          ),

                          ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: Size(0, 40),
                              //primary: Color(0xfffa4a0c),
                            ),
                            onPressed: () {
                              setState(() {
                                if ((step_contents.text.isEmpty)) return;
                                num++;
                                step_list.add(new Add_Step_Detail(num, step_contents.text, File(step_img.path)));

                              });
                            },
                            child: Text(
                              'STEP 추가',
                              style: TextStyle(
                                color: Colors.white,
                                //fontSize: 16,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 5,
            ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 400,
            child: FutureBuilder(
                future: _get_ingrd_input(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView(
                    padding: EdgeInsets.only(left: 2, bottom: 5, top: 5),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: buildStepList(step_list),
                  );
                }

            ),
          ),

            // 완성 체크
            IconButton(
              onPressed: () async {

                // 제목 제목 이미지 저장
                if (thumb != null) {
                  id = await addMainRecipe(
                      title.text, await getSharedPrefUser(),
                      thumb: thumb);
                } else {
                  id = await addMainRecipe(
                      title.text, await getSharedPrefUser());
                }

                // 재료 & 함량 저장
                for (int i = 0; i < ingrd_list.length; i++) {
                  await addIngreUnit(ingrd_list[i].unit,
                      id, ingrd_list[i].ingrd_name);
                }

                // 순서 저장
                print("length: " + step_list.length.toString());
                for (int i = 0; i < step_list.length; i++) {

                  // if (step_list[i].img != null) {
                  //   await addStepRecipe( step_list[i].num, step_list[i].contents, id, img: step_list[i].img);
                  // } else {
                  //   await addStepRecipe( step_list[i].num, step_list[i].contents, id );
                  // }

                  print("id: " + id.toString());
                  Map<String, dynamic> body = {
                    "num": step_list[i].num,
                    "contents": step_list[i].contents,
                    "recipe_id": id
                  };

                  if(step_list[i].img != null) {
                    final bytes = await Io.File(step_list[i].img!.path).readAsBytes();
                    String img64 = base64Encode(bytes);
                    body["img"] = img64;
                  }

                  final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/steps/add/"),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },

                      body: json.encode([body]));

                  if (response.statusCode == 201) {
                    print("done");
                    //Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
                    //user = User.fromJson(data);
                  } else {
                    throw Exception(
                        'failed get ID ') ; //TODO exception handling...
                  }
                }

                Navigator.pop(context);
              },

              // 사진 추가
              icon: Icon(Icons.check_circle),
              iconSize: 50.0,
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
      ),
    );
  }


  // 순서 추가
  List<Widget> buildStepList(List<Add_Step_Detail> steps) {
    List<Widget> list = [];

    for (var i = 0; i < steps.length; i++) {
      list.add(buildStep(steps[i], i+1));
      list.add(
        SizedBox(
          height: 5,
        ),
      );
    }
    return list;
  }

  Widget buildStep(Add_Step_Detail step, int index) {
    // 조리 순서
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [

          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.file(step.img).image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  buildRecipeTitle("STEP " + index.toString()),

                  buildRecipeSubTitle(step.contents),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }


  // 재료 추가
  Future<List<Unit>> _get_ingrd_input() async {
    return ingrd_list;
  }

  List<Widget> buildIngrds(List<Unit> getIngrds) {
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getIngrds.length; i++) {
      list.add(buildIngrd(getIngrds[i], i));
      list.add(
        SizedBox(
          width: 10,
        ),
      );
    }
    return list;
  }

  Widget buildIngrd(Unit ingrd_set, int index) {
    return
      TextButton(
        style: TextButton.styleFrom(
            textStyle: TextStyle(fontWeight: FontWeight.w600),
            backgroundColor: Colors.white,
            primary: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),

        onPressed: () {
          setState(() {
            ingrd_list.removeWhere((item) => item == ingrd_set);
          });

          print(ingrd_list[0].unit);
        },
        child: Text(ingrd_set.ingrd_name + " / " + ingrd_set.unit),
        // child: const Text("Hi"),
      );
  }
}

  Future<XFile?> getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    //print(File(image!.path));
    return image;
  }


