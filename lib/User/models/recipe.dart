import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yorizori_app/User/models/step_unit.dart';
import 'package:yorizori_app/urls.dart';

class Recipe {
  int id;
  String title;
  DateTime created_date;
  int views;
  String thumb;
  int writer;
  List<Unit> units = [];
  List<Step> steps = [];

  Recipe(this.id, this.title, this.created_date, this.views, this.thumb,
      this.writer, this.units, this.steps);

  Recipe.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        created_date = DateTime.parse(json['created_date']),
        views = json['views'],
        thumb = json['thumb'],
        writer = json['writer'];
}

Future<List<Recipe>> parseRecipeList(String responseBody) async {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  List<Recipe> recipeList =
      parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  // for (var i = 0; i < recipeList.length; i++) {
  //   int recipe_id = recipeList[i].id;
  //   recipeList[i].units = await getUnitList(recipe_id);
  //   recipeList[i].steps = await getStepList(recipe_id);
  // }
  return recipeList;
}

Future<List<Recipe>> getRecipeList({user_id, flag, recipe_list}) async {
  List<Recipe> recipeList = [];
  try {
    var url = UrlPrefix.urls + 'recipe/list/';
    final response;

    if (user_id != null) {
      url += user_id.toString() + "/";
      response = await http.get(Uri.parse(url));
    } else if (flag != null && recipe_list != null) {
      response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"flag": flag, "recipe_list": recipe_list}));
    } else {
      throw Exception('getRecipeList parameter error');
    }

    if (response.statusCode == 200) {
      recipeList = await parseRecipeList(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('falied get recipe list with ' + flag.toString());
    }
  } catch (e) {
    print(e);
  }
  return recipeList;
}

Future<Recipe> getRecipe(int recipe_id) async {
  var recipe;
  final response = await http
      .get(Uri.parse(UrlPrefix.urls + "recipe/" + recipe_id.toString()));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    recipe = Recipe.fromJson(data);
  } else {
    throw Exception(
        'failed get User ' + recipe_id.toString()); //TODO exception handling...
  }
  return recipe;
}
