import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yorizori_app/Home/textStyle.dart';
import 'package:yorizori_app/Home/AddRecipe/addRecipe.dart';
import 'package:yorizori_app/Camera/camera.dart';
import 'package:yorizori_app/Camera/ingre_name_list.dart';
import 'package:yorizori_app/sharedpref.dart';

import 'dart:io';

import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/addRecipeList.dart';

class AddPage extends StatelessWidget {

  late File _image;

  late String title;

  List<String> add_list = [];

  final _InputController = TextEditingController();

  Future<List<String>> _getinput() async {
    return add_list;
  }

  //final RecipeList recipe;

  //DetailPage(this.recipe);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
              color: Colors.white,//Color(0xffFA4A0C),
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
        child: Column( children: [
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
                  width: 300,
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
                  controller: _InputController,
                ),
              ),
              ),

              IconButton( // 사진 추가
                  onPressed: () async {
                      await addMainRecipe( _InputController.text , await getSharedPrefUser() );
                      //sharedPreference
                      //addMainRecipe( title ,writer, {thumb})
                    
                  },
                  icon: Icon(Icons.add_to_photos_rounded),
                  iconSize: 50.0,
                  color: Colors.deepOrangeAccent,
              ),

            ],
          ),

          SizedBox(
            height: 20,
          ),

          //사진 올리기
          /*Container(
            width: 360,
            height: 300,
            decoration:  BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('',)
              ),
            ),

          ),*/

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

          //재료 추가

          /*
          SizedBox(
            width: 5,
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
              controller: _dislikeController,
            ),
          ),
          SizedBox(width: width * 0.02),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: Size(0, 40),
              //primary: Color(0xfffa4a0c),
            ),
            onPressed: () {
              setState(() {
                if (_dislikeController.text.isEmpty == true) return;

                for (var i = 0; i < dislike_list.length; i++) {
                  if (dislike_list[i].compareTo(_dislikeController.text) ==
                      0) {
                    return;
                  }
                }

                dislike_list.add(_dislikeController.text);
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
            width: 200,
          ),
        ],
        ),
        SizedBox(
          height : 2,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          height: height * 0.07,
          child: FutureBuilder(
              future: _getinput(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ListView(
                  padding: EdgeInsets.only(left: 2, bottom: 5, top: 5),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: buildDislikes(dislike_list),
                );
              }),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            child: Text("수정"),
            onPressed: () {
              profileUpadte(new_disliked: dislike_list);
            },
          ),
        ) *///재료 추가 끝

          // 완성 체크
          IconButton( // 사진 추가
            onPressed: () async {
              await addMainRecipe( _InputController.text , await getSharedPrefUser() );

              //addMainRecipe( title ,writer, {thumb})
            },
            icon: Icon(Icons.check_circle),
            iconSize: 50.0,
            color: Colors.deepOrangeAccent,
          ),
        ],
      ),
      ),
    );
  }
}

/*
Future<XFile?> getImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  var image = await _picker.pickImage(source: ImageSource.gallery);
  return image;
}

class pickMainImage extends StatefulWidget {
  Function setter;
  User user;
  pickMainImage({Key? key, required this.user, required this.setter})
      : super(key: key);

  @override
  _pickMainImageState createState() => _pickMainImageState();
}

class _pickMainImageState extends State<pickMainImage> {
  var profile_image;
  @override
  void initState() {
    super.initState();
    profile_image = (widget.user.profile_img != '')
        ? NetworkImage(widget.user.profile_img)
    //Image.network(user.profile_img) as ImageProvider
        : AssetImage('assets/images/wink.png') as ImageProvider;
  }

  @override
  Widget build(BuildContext context) {
    var new_profile_image;
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      width: width * 0.5,
      height: height * 0.13,
      alignment: Alignment.center,
      child: Stack(children: [
        CircleAvatar(radius: width * 0.08, backgroundImage: profile_image),
        Positioned(
          height: height * 0.043,
          child: FloatingActionButton(
            onPressed: () async {
              new_profile_image = await getImageFromGallery();
              if (new_profile_image != null) {
                setState(() {
                  profile_image =
                      Image.file(File(new_profile_image.path)).image;
                });
                widget.setter(new_profile_image);
              }
            },
            shape: CircleBorder(
                side: BorderSide(
                    width: 2, color: Theme.of(context).primaryColor)),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.camera_enhance,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
          right: 0,
          left: width * 0.1,
          bottom: -height * 0.001,
        ),
      ]),
    );
  }
}
*/