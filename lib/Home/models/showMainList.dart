import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yorizori_app/Camera/models/Recipe_one.dart';

import 'package:yorizori_app/urls.dart';

List<Recipe_One> recipes = [];

Future<List<Recipe_One>> showPopularRecipe(flag, vegan, disliked_list) async {
  recipes = [];

  Map<String, dynamic> body = {
    "flag": flag,
    "vegan": vegan,
    "disliked": disliked_list,
  };

  final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/list/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: json.encode(body));

  if (response.statusCode == 201) {
    Map<String, dynamic> Data = jsonDecode(utf8.decode(response.bodyBytes));
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

      recipes.add(recipe);
    }
  } else {
    throw Exception(
        'failed get ID ') ; //TODO exception handling...
  }

  return recipes;
}