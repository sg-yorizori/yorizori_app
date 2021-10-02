import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/textStyle.dart';

class DetailPage extends StatelessWidget {

  final RecipeList recipe;

  DetailPage(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        brightness: Brightness.light,

        title: Text(
            "레시피 보기",
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite_border,
              color: Colors.white, //Color(0xffFA4A0C),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Stack(children: [
              Positioned(
                //right: 50,
                child: Hero(
                  tag: recipe.mainImage[0],
                  child: Container(
                    //alignment: Alignment.topCenter,
                    height: 310,
                    width: 410,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(recipe.mainImage[0]),
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

                  buildTextTitleVariation1(recipe.title),

                  //buildTextSubTitleVariation1("조회수 " + recipe.views.toString() + "회"),
                  //buildTextSubTitleVariation1_right("작성자 " + recipe.writer),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "조회수 " + recipe.views.toString() + "회",
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
                              "작성자 " + recipe.writer,
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

                      buildTextTitleVariation2('재료', false),

                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 20,
                        runSpacing: 16,
                        children:
                          buildIngred(recipe),
                      ),

                      SizedBox(
                        height: 16,
                      ),

                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation2('조리 순서', false),

                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 20,
                    runSpacing: 10,
                    children:
                    buildCookList(recipe),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildCookList(RecipeList recipes) {
    List<Widget> list = [];

    for(var i = 0; i < recipe.recipeImage.length; i++) {
      list.add(buildCook(recipe.recipeStep[i], recipe.recipeImage[i], i+1));
    }
    return list;
  }

  Widget buildCook(String step, String pic, int num) { // 조리 순서
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

                  buildRecipeTitle("STEP " + num.toString()),

                  buildRecipeSubTitle(step),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  List<Widget> buildIngred(RecipeList recipes) {
    List<Widget> list = [];

    for(var i = 0; i < recipe.ingredName.length; i++) {
      list.add(buildNutrition(recipe.ingredAmount[i], recipe.ingredName[i]));
    }
    return list;
  }

  Widget buildNutrition(String amount, String name){ // 레시피 재료
    return Container(
      height: 60,
      width: 160,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffFA4A0C),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: new Wrap(
        children: <Widget> [

          Container(
            height: 45,
            width: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              //shape: BoxShape.circle,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              boxShadow: [kBoxShadow],
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
              child: Text(
                amount,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}