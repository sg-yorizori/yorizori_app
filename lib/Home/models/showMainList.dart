import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:yorizori_app/urls.dart';

Future<int> showPopularRecipe(flag, vegan, disliked_list) async {
  var id;

  Map<String, dynamic> body = {
    "flag": flag,
    "vegan": vegan,
    "disliked": disliked_list,
  };

  final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/add/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: json.encode(body));

  if (response.statusCode == 201) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    //user = User.fromJson(data);
    id = data["id"];
    print(id);
  } else {
    throw Exception(
        'failed get ID ') ; //TODO exception handling...
  }

  return id;
}

void addStepRecipe(id) async {

  Map<String, dynamic> body = {
    "recipe_id" : id
  };

  final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/steps/add/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: json.encode(body));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    //user = User.fromJson(data);
    id = data["id"];
  } else {
    throw Exception(
        'failed get ID ') ; //TODO exception handling...
  }
}

