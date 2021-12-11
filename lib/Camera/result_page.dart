import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorizori_app/Home/textStyle.dart';
import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;
import './ingre_name_list.dart';
import './models/Recipe_one.dart';

import 'dart:async';
import 'dart:convert';
import './detail.dart';

List<Recipe_One> recipes = [];

class ResultPage extends StatefulWidget {
  // const ResultPage({Key? key}) : super(key: key);
  final Function flag_update;
  ResultPage(this.flag_update);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<List<String>> _getinput() async {
    return ingre_name_list;
  }

  Future<List<Recipe_One>> _getRecipes() async {
    recipes = [];
    String search = '';

    for (var i = 0; i < ingre_name_list.length; i++) {
      if (i == 0)
        search = ingre_name_list[i];
      else {
        search = search + ' ' + ingre_name_list[i];
      }
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(UrlPrefix.urls + "recipe/list/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "flag": 4,
        "vegan": sharedPreferences.getInt("vegan"),
        "disliked": sharedPreferences.getStringList("disliked"),
        "search": search
      }),
    );
    if (response.statusCode == 200) {
      final Data = jsonDecode(utf8.decode(response.bodyBytes));
      if (Data != null && mounted) {
        var len;
        if (Data.length > 10)
          len = 10;
        else {
          len = Data.length;
        }
        // for (var i = 0; i < Data.length; i++) {
        for (var i = 0; i < len; i++) {
          var titleFromJson = Data[i]["title"];
          DateTime dateFromJson = DateTime.parse(Data[i]["created_date"]);
          var thumbFromJson = Data[i]["thumb"];

          // created_date = DateTime.parse(json['created_date']),

          Recipe_One recipe = Recipe_One(
            Data[i]["id"],
            titleFromJson,
            dateFromJson,
            Data[i]["views"],
            thumbFromJson,
            Data[i]["writer"],
          );
          recipes.add(recipe);
        }
      }
    } else {
      throw Exception();
    }
    print("!!!!");
    print(recipes.length);
    return recipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 0,
          title: const Text(
            "검색 결과",
            style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FutureBuilder(
              future: _getRecipes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16, left: 20),
                      decoration: BoxDecoration(
                        color: Color(0xffe3e3e3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 55,
                      child: FutureBuilder(
                          future: _getinput(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return ListView(
                              padding:
                                  EdgeInsets.only(left: 2, bottom: 5, top: 5),
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: buildIngres(ingre_name_list),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 20,
                      runSpacing: 10,
                      children: buildRecipes(recipes),
                    ),
                  ]),
                );
              }),
        ));
  }

  // ************************ //
  List<Widget> buildIngres(List<String> input_list) {
    List<Widget> list = [];
    for (var i = -1; i < input_list.length; i++) {
      if (i == -1) {
        list.add(Container(
            child: Row(children: [
          SizedBox(
            width: 15,
          ),
          Icon(
            Icons.search_rounded,
            color: Colors.deepOrangeAccent,
            size: 30,
          ),
          SizedBox(
            width: 15,
          ),
        ])));
      } else {
        list.add(buildIngre(input_list[i], i));
        list.add(
          SizedBox(
            width: 10,
          ),
        );
      }
    }
    return list;
  }

  Widget buildIngre(String ingre_one, int index) {
    return TextButton(
      style: TextButton.styleFrom(
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600),
          backgroundColor: Colors.white,
          primary: Colors.deepOrangeAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        setState(() {
          ingre_name_list.removeWhere((item) => item == ingre_one);
        });
        widget.flag_update();
      },
      child: Text(ingre_one),
    );
  }

  List<Widget> buildRecipes(List<Recipe_One> input_list) {
    List<Widget> list = [];
    for (var i = 0; i < input_list.length; i++) {
      list.add(buildRecipe(input_list[i], i));
    }
    return list;
  }

  Widget buildRecipe(Recipe_One recipe_one, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage2(recipe_one)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        child: Row(children: [
          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe_one.thumb),
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

                    buildRecipeTitle(recipe_one.title),

                    buildTextSubTitleVariation2("조회수 " + recipe_one.views.toString()),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        buildBottomRecipe("레시피 보기"),

                      ],
                    ),

                  ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
