import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorizori_app/Camera/detail.dart';
import 'package:yorizori_app/Camera/models/Recipe_one.dart';
import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../textStyle.dart';

List<Recipe_One> recipes = [];

class resultList extends StatefulWidget {
  String search_title_name = '';

  resultList(this.search_title_name);


  @override
  _searchTitle createState() => _searchTitle();

}

class _searchTitle extends State<resultList> {

/*
  @override
  void initState() {
    super.initState();
    print(widget.search_title_name);
  }*/

  Future<List<Recipe_One>> _getRecipes() async {
    recipes = [];
    String search = '';

    search = widget.search_title_name;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> body = {
      "search" : search
    };

    final response = await http.post(
        Uri.parse(UrlPrefix.urls + "recipe/list/title/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: json.encode(body));
  /*    body: jsonEncode({
          "search": search
        }),
    ); */

    if (response.statusCode == 200) {
      //Map<String, dynamic> Data = jsonDecode(utf8.decode(response.bodyBytes));
      final Data = jsonDecode(utf8.decode(response.bodyBytes));
      for (var i = 0; i < Data.length; i++) {
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
      // id = data["id"];
      // print(id);
    } else {
      throw Exception(
          'failed get ID ') ; //TODO exception handling...
    }

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
        body:
        Container(
          height:800,
          child: FutureBuilder(
              future: _getRecipes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      child: Center(child: Text("로딩중...")));
                } else {
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: buildRecipes(recipes),
                  );
                  //);
                }
              }
          ),
        ),
    );
  }

  List<Widget> buildRecipes (List<Recipe_One> getRecipes){
    List<Widget> list = [];
    for (var i = 0; i < getRecipes.length; i++) {
      list.add(buildRecipe(getRecipes[i], i));
    }
    return list;
  }

  Widget buildRecipe(Recipe_One recipe, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    DetailPage2(recipe)));
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
        child: Row(
          children: [

            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.thumb),
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

                    buildRecipeTitle(recipe.title),

                    buildTextSubTitleVariation2("조회수 " + recipe.views.toString()),

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

          ],
        ),
      ),
    );
  }

}
