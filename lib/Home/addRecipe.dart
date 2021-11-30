import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/textStyle.dart';

class AddPage extends StatelessWidget {

  //final RecipeList recipe;

  //DetailPage(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,

        title: Text(
            "나의 레시피 공유하기",
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
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 16),
        //     child: Icon(
        //       Icons.favorite_border,
        //       color: Colors.white, //Color(0xffFA4A0C),
        //     ),
        //   ),
        // ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '요리 이름',
                  ),
                ),
              ),
      ],
        ),
      ),
    );
  }
}