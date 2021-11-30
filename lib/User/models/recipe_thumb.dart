import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yorizori_app/urls.dart';

class RecipeThumb {
  int id;
  String title;
  DateTime created_date;
  int views;
  String thumb;
  int writer;

  RecipeThumb(this.id, this.title, this.created_date, this.views, this.thumb,
      this.writer);

  RecipeThumb.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        created_date = DateTime.parse(json['created_date']),
        views = json['views'],
        thumb = json['thumb'],
        writer = json['writer'];
}

List<RecipeThumb> parseRecipeThumbList(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<RecipeThumb>((json) => RecipeThumb.fromJson(json)).toList();
}

Future<List<RecipeThumb>> getRecipeThumbList(
    {user_id, flag, recipe_list}) async {
  List<RecipeThumb> recipeThumbList = [];
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
      throw Exception('getRecipeThumbList parameter error');
    }

    if (response.statusCode == 200) {
      recipeThumbList = parseRecipeThumbList(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('falied get recipe list with ' + flag.toString());
    }
  } catch (e) {
    print(e);
  }
  return recipeThumbList;
}
