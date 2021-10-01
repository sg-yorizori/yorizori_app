import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/camera.dart';

class Recipe extends StatefulWidget {
  Recipe({Key? key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("recipe test!!!!!!!!"),
      ),
    );
  }
}

