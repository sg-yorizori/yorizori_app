import 'package:flutter/material.dart';
import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import './models/step.dart';
import './models/Recipe_one.dart';
import './ingre_name_list.dart';

import 'package:shared_preferences/shared_preferences.dart';

List<Step_detail> steps = [];

class DetailPage2 extends StatefulWidget {
  DetailPage2(this.recipe);
  final Recipe_One recipe;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailPage2> {
  var _flag;

  _getLike() async {
    print("get Like");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("user_id:");
    print(sharedPreferences.getInt("user_id"));

    final response = await http.post(
      Uri.parse(UrlPrefix.urls + "users/profile/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user_id": sharedPreferences.getInt("user_id"),
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && mounted) {
        print("Bookmark: ");
        print(data["bookmark"]);
        print("Recipe ID: ");
        print(widget.recipe.id);

        for (var i = 0; i < data["bookmark"].length; i++) {
          if (data["bookmark"][i] == widget.recipe.id) {
            _flag = 1;
            return;
          }
        }
        _flag = 0;
        return;
      }
    } else {
      throw Exception();
    }
  }

  Future _deleteBookmark() async {
    var tem_data;

    print("Delete Bookmark");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(UrlPrefix.urls + "users/profile/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user_id": sharedPreferences.getInt("user_id"),
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && mounted) {
        print("Before Bookmark: ");
        print(data["bookmark"]);
        print("Recipe ID: ");
        print(widget.recipe.id);

        for (var i = 0; i < data["bookmark"].length; i++) {
          if (data["bookmark"][i] == widget.recipe.id) {
            data["bookmark"].remove(widget.recipe.id);

            print("After Bookmark: ");
            print(data["bookmark"]);
          }
        }
        tem_data = data["bookmark"];
      }
    } else {
      throw Exception();
    }

    print("TEM DATA");
    print(tem_data);
    final response2 = await http.post(
      Uri.parse(UrlPrefix.urls + "users/profile/update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user_id": sharedPreferences.getInt("user_id"),
        "bookmark": tem_data
      }),
    );
    if (response2.statusCode == 200) {
      final data = json.decode(response2.body);
      if (data != null && mounted) {
        print("After Bookmark222 : ");
        print(data["bookmark"]);
      }
    } else {
      throw Exception();
    }
  }

  Future _insertBookmark() async {
    var tem_data;

    print("Insert Bookmark");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(UrlPrefix.urls + "users/profile/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user_id": sharedPreferences.getInt("user_id"),
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && mounted) {
        print("Before Bookmark: ");
        print(data["bookmark"]);
        print("Recipe ID: ");
        print(widget.recipe.id);

        data["bookmark"].add(widget.recipe.id);

        tem_data = data["bookmark"];
      }
    } else {
      throw Exception();
    }

    print("TEM DATA");
    print(tem_data);
    final response2 = await http.post(
      Uri.parse(UrlPrefix.urls + "users/profile/update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user_id": sharedPreferences.getInt("user_id"),
        "bookmark": tem_data
      }),
    );
    if (response2.statusCode == 200) {
      final data = json.decode(response2.body);
      if (data != null && mounted) {
        print("After Bookmark222 : ");
        print(data["bookmark"]);
      }
    } else {
      throw Exception();
    }
  }

  Future<List<Step_detail>> _getSteps() async {
    if (steps.length == 0) {
      steps = [];
      final response = await http.get(
        Uri.parse(
            UrlPrefix.urls + "recipe/steps/all/" + widget.recipe.id.toString()),
      );
      if (response.statusCode == 200) {
        final Data = jsonDecode(utf8.decode(response.bodyBytes));
        if (Data != null && mounted) {
          for (var i = 0; i < Data.length; i++) {
            Step_detail step = Step_detail(Data[i]["id"], Data[i]["num"],
                Data[i]["contents"], Data[i]["img"], Data[i]["recipe_id"]);

            steps.add(step);
          }
        }
      } else {
        throw Exception();
      }
      print("Steps Length: ");
      print(steps.length);
      return steps;
    }
    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("레시피 보기",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, //Color(0xffFA4A0C),
            )),
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
        actions: [
          FutureBuilder(
              future: _getLike(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (_flag == 1) {
                  return new IconButton(
                    onPressed: () async {
                      await _deleteBookmark();
                      setState(() {
                        _flag = 0;
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(right: 16),
                  );
                } else {
                  return new IconButton(
                    onPressed: () async {
                      await _insertBookmark();
                      setState(() {
                        _flag = 1;
                      });
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(right: 16),
                  );
                }
              }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(right: 16, left: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FutureBuilder(
            future: _getSteps(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(children: [
                        Positioned(
                          //right: 50,
                          child: Hero(
                            tag: widget.recipe.thumb,
                            child: Container(
                              //alignment: Alignment.topCenter,
                              height: 310,
                              width: 410,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.recipe.thumb),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // buildTextTitleVariation1(recipe.title),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(widget.recipe.title,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFA4A0C),
                                  )),
                            ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "조회수 " +
                                          widget.recipe.views.toString() +
                                          "회",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "작성자 ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        //height: 310,
                        padding: EdgeInsets.only(left: 16),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // buildTextTitleVariation2('재료', false),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    '재료',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFA4A0C),
                                    ),
                                  ),
                                ),

                                Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 20,
                                  runSpacing: 16,
                                  children: buildIngred(widget.recipe),
                                ),

                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // buildTextTitleVariation2('조리 순서', false),

                            Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Text(
                                '조리 순서!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffFA4A0C),
                                ),
                              ),
                            ),

                            Wrap(
                              direction: Axis.horizontal,
                              spacing: 20,
                              runSpacing: 10,
                              children: buildCookList(widget.recipe),
                            ),
                          ],
                        ),
                      ),
                    ]),
              );
            }),
      ),
    );
  }

  List<Widget> buildCookList(Recipe_One recipes) {
    List<Widget> list = [];

    print(steps.length);

    for (var i = 0; i < steps.length; i++) {
      list.add(buildCook(steps[i].contents, steps[i].img, i + 1));
    }
    return list;
  }

  Widget buildCook(String step, String pic, int num) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        // boxShadow: [kBoxShadow],
      ),
      child: Row(children: [
        Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(pic),
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
                // buildRecipeTitle("STEP " + num.toString()),

                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "STEP " + num.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),

                // buildRecipeSubTitle(step),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    step,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  List<Widget> buildIngred(Recipe_One recipe) {
    List<Widget> list = [];

    print("11111");
    print(ingre_name_list.length);

    for (var i = 0; i < ingre_name_list.length; i++) {
      list.add(buildNutrition("test", ingre_name_list[i]));
    }
    return list;
  }

  Widget buildNutrition(String amount, String name) {
    return Container(
      height: 60,
      width: 160,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffFA4A0C),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        // boxShadow: [kBoxShadow],
      ),
      child: new Wrap(
        children: <Widget>[
          Container(
            height: 45,
            width: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              //shape: BoxShape.circle,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              // boxShadow: [kBoxShadow],
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
              height: 45,
              width: 60,
              child: Center(
                child: Icon(Icons.camera_alt_rounded,
                    color: Colors.white, size: 35),
              )

              // child: Center(
              //   child: Text(
              //     amount,
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              ),
        ],
      ),
    );
  }
}
