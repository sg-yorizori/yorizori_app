import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yorizori_app/Home/addRecipe.dart';
import 'dart:convert';
import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/search.dart';
import 'package:yorizori_app/Home/detail.dart';
import 'package:yorizori_app/Home/textStyle.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Home> {

  Future<List<RecipeList>> _getRecipes() async {
    String data = await rootBundle.loadString('assets/data.json');
    final jsonData = json.decode(data);
    //print(jsonData["1"]["recipe_image"][0]);

    List<RecipeList> recipes = [];

    for (var i = 0; i < jsonData.length; i++) {
      //print(jsonData["$i"]["recipe_image"][0]);
      //List<String> mainImageList = jsonData[i.toString()]["main_image"];

      var mainImageFromJson = jsonData[i.toString()]["main_image"];
      List<String> mainImageList = new List<String>.from(mainImageFromJson);

      var ingredNameFromJson = jsonData[i.toString()]["ingred_name"];
      List<String> ingredNameList = new List<String>.from(ingredNameFromJson);

      var ingredAmountFromJson = jsonData[i.toString()]["ingred_amount"];
      List<String> ingredAmountList = new List<String>.from(
          ingredAmountFromJson);

      var recipeStepFromJson = jsonData[i.toString()]["recipe_step"];
      List<String> recipeStepList = new List<String>.from(recipeStepFromJson);

      var recipeImageFromJson = jsonData[i.toString()]["recipe_image"];
      List<String> recipeImageList = new List<String>.from(recipeImageFromJson);

      RecipeList recipe = RecipeList(
        title: jsonData[i.toString()]["title"],
        mainImage: mainImageList,
        ingredName: ingredNameList,
        ingredAmount: ingredAmountList,
        recipeStep: recipeStepList,
        recipeImage: recipeImageList,
        views: jsonData[i.toString()]["views"],
        writer: jsonData[i.toString()]["writer"],
      );
      recipes.add(recipe);
    }
    //print(recipes[0].mainImage[0]);
    //print(recipes[1].recipeImage[4]);

    print(recipes.length);

    return recipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
                "재료와 레시피를 요리조리 찾아봐요",
              style: TextStyle(color: Colors.grey[400])
            ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            }
          )
        ]
        /*
        title: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: TextFormField(
              decoration: InputDecoration(
                //labelText: '재료와 레시피를 요리조리 찾아봐요',
                icon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),

              ),
            ),
          ),
        ),*/
      ),
      drawer: Drawer(),

      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: 20,
                ),

                Container(
                  height: 350,
                  // child: Expanded(
                  child: FutureBuilder(
                      future: _getRecipes(),
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
                  height: 190,
                  child: FutureBuilder(
                      future: _getRecipes(),
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
          child: Icon(Icons.add, size: 30.0),
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepOrangeAccent,
          shape: CircleBorder(side: BorderSide (color: Colors.deepOrangeAccent, width: 3.0))
      ),
    );
  }

  List<Widget> buildPopulars(List<RecipeList> getRecipes){
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getRecipes.length; i++) {
      list.add(buildPopular(getRecipes[i], i));
    }
    return list;
  }

  Widget buildPopular(RecipeList recipe, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    DetailPage(recipe)));
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
                tag: recipe.mainImage[0],
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(recipe.mainImage[0]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            buildRecipeTitle(recipe.title),

            buildTextSubTitleVariation2("작성자 " + recipe.writer),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                buildBottomRecipe("조회수 " + recipe.views.toString() + " 회"),

                Icon(
                  Icons.favorite_border,
                )

              ],
            ),

          ],

        ),
      ),
    );
  }

  List<Widget> buildRecents (List<RecipeList> getRecipes){
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getRecipes.length; i++) {
      list.add(buildRecent(getRecipes[i], i));
    }
    return list;
  }

  Widget buildRecent(RecipeList recipe, int index){
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
                image: NetworkImage(recipe.mainImage[0]),
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

                  buildTextSubTitleVariation2("작성자 " + recipe.writer),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildBottomRecipe("레시피 보기"),

                      Icon(
                        Icons.favorite_border,
                      )

                    ],
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}