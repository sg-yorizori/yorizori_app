import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yorizori_app/Camera/detail.dart';
import 'package:yorizori_app/Home/AddRecipe/addRecipe.dart';
import 'dart:convert';
import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/detail.dart';
import 'package:yorizori_app/Home/textStyle.dart';
import 'package:yorizori_app/Camera/models/Recipe_one.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorizori_app/Home/dataFromAPI.dart';

import '../sharedpref.dart';
import '../urls.dart';
import 'Search/resultList.dart';

List<Recipe_One> main_popular_list = [];
List<Recipe_One> main_recent_list = [];

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Home> {

  StreamController<String> streamController = StreamController<String>();

  TextEditingController controller = new TextEditingController();

  Future<List<Recipe_One>> showPopularRecipe() async {
    main_popular_list = [];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> body = {
      "flag": 2,
      "vegan": 0,
      "disliked": sharedPreferences.getStringList("disliked"),
    };

    final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/list/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: json.encode(body));

    if (response.statusCode == 200) {
      final Data = jsonDecode(utf8.decode(response.bodyBytes));
      if (Data != null && mounted) {
        //user = User.fromJson(data);
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
          main_popular_list.add(recipe);
      }
      }
    } else {
      throw Exception(
          'failed get ID ') ; //TODO exception handling...
    }

    return main_popular_list;
  }

  Future<List<Recipe_One>> showRecentRecipe() async {
    main_recent_list = [];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> body = {
      "flag" : 3,
      "vegan" : 0,
      "disliked" : sharedPreferences.getStringList("disliked"),
    };

    final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/list/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: json.encode(body));

    if (response.statusCode == 200) {
      final Data = jsonDecode(utf8.decode(response.bodyBytes));
      //user = User.fromJson(data);
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

        main_recent_list.add(recipe);
      }
    } else {
      throw Exception(
          'failed get ID ') ; //TODO exception handling...
    }

    return main_recent_list;
  }

  @override
  Widget build(BuildContext context) {

    String search_title_data = "";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrangeAccent,
        title: Center(

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),

            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              // onChanged: (text) {
              //   //searchTitle(text);
              //   //_streamSearch.add(text);
              //
              //   title_data = text;
              //   resultList();
              // },
              onSubmitted: (String str) {
                setState(() {

                  search_title_data = str;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>
                        resultList(search_title_data)));

                  //resultList(search_title_data);

                });
              },
              decoration: InputDecoration(
                hintText: '재료와 레시피를 요리조리 찾아봐요',
                icon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),

              ),
            ),

              //resultList(title_data);
              //resultList(search_title_data);
          ),
        ), //
      ),

      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      buildTextTitleVariation1('인기 메뉴'),
                      buildTextSubTitleVariation1('오늘은 이런 음식 어때요?')

                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  height: 350,
                  // child: Expanded(
                  child: FutureBuilder(
                      future: showPopularRecipe(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                              child: Center(child: Text("로딩중...")));
                        } else {
                          return ListView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: buildPopulars(snapshot.data),
                              );
                          //);
                        }
                      }
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [

                      buildTextTitleVariation2('따끈따끈', false),

                      SizedBox(
                        width: 8,
                      ),

                      buildTextTitleVariation2('레시피', true),

                    ],
                  ),
                ),

                Container(
                  height:400,
                  child: FutureBuilder(
                      future: showRecentRecipe(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                              child: Center(child: Text("로딩중...")));
                        } else {
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: buildRecents(snapshot.data),
                          );
                          //);
                        }
                      }
                  ),
                ),
              ]
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        AddPage()));
          },
          child: Icon(Icons.add, size: 30.0 ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepOrangeAccent,
          shape: CircleBorder(side: BorderSide (color: Colors.deepOrangeAccent, width: 3.0))
      ),
    );
  }

  List<Widget> buildPopulars(List<Recipe_One> getRecipes){
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getRecipes.length; i++) {
      list.add(buildPopular(getRecipes[i], i));
    }
    return list;
  }

  Widget buildPopular(Recipe_One recipe, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    DetailPage2(recipe)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              child: Hero(
                tag: recipe.thumb,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(recipe.thumb),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            buildRecipeTitle(recipe.title),

            buildTextSubTitleVariation2("작성일자 " + recipe.created_date.toString()),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                buildBottomRecipe("조회수 " + recipe.views.toString() + " 회"),

                Icon(
                  Icons.call_made,
                )

              ],
            ),

          ],

        ),
      ),
    );
  }

  List<Widget> buildRecents (List<Recipe_One> getRecipes){
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getRecipes.length; i++) {
      list.add(buildRecent(getRecipes[i], i));
    }
    return list;
  }

  Widget buildRecent(Recipe_One recipe, int index){
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

                  buildTextSubTitleVariation2("조회수 " + recipe.views.toString() + " 회회"),

                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

