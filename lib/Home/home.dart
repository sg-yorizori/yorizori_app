import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/camera.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
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
        title: const Text("재료와 레시피를 요리조리에서 찾아봐요"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      drawer: Drawer(),

      body:
        Container(
          child: FutureBuilder(
            future: _getRecipes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                    child: Center(
                        child: Text("Loading...")
                    )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data[index].mainImage[0]
                        ),
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text("레시피 보기"),
                      onTap: () {
                        Navigator.push( context,
                            new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.deepOrangeAccent,
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 40,
          ),
          label: Text(
            "레시피 추가",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
      ),
    );
  }
}

/* SingleChildScrollView(
            physics: BouncingScrollPhysics(),

            child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        buildTextTitleVariation1('인기 메뉴'),
                        buildTextSubTitleVariation1('오늘은 이런 음식 어때요?'),

                      ],
                    ),
                  ),

                  Container(
                    height: 350,
                    // child: Expanded(
                    child: FutureBuilder(
                        future: _getRecipes(),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                                child: Center(child: Text("Loading...")));
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: buildRecipes(snapshot.data),
                                );
                              },
                            );
                          }
                        }
                    ),
                  )
                ]
            )
        )
    );
  }

  List<Widget> buildRecipes(List<RecipeList> getRecipes){
    print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getRecipes.length; i++) {
      list.add(buildRecipe(getRecipes[i], i));
    }
    return list;
  }

  Widget buildRecipe(RecipeList recipe, int index){
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
                      image: AssetImage(recipe.mainImage[0]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            buildRecipeTitle(recipe.title),

            buildTextSubTitleVariation2("작성자 " + recipe.writer),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                buildCalories("조회수 " + recipe.views.toString() + " 회"),

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
}
*/