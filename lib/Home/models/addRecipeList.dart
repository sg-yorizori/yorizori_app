import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;
//import 'package:yorizori_app/User/models/recipe.dart';
import 'package:yorizori_app/urls.dart';
import 'package:yorizori_app/sharedpref.dart';

//Future<int> addMainRecipe(title,writer, {thumb}) async {
Future<int> addMainRecipe(title, writer, {thumb}) async {
  var id;

  Map<String, dynamic> body = {
    "title": title,
    "writer": writer
  };

  if(thumb != null) {
    final bytes = await Io.File(thumb!.path).readAsBytes();
    String img64 = base64Encode(bytes);
    body["thumb"] = img64;
  }

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

Future<void> addIngreUnit(unit, id, ingrd_id) async{

  Map<String, dynamic> body = {
    "unit": unit,
    "recipe_id": id,
    "ingrd_id": ingrd_id
  };

  final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/unit/add/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: json.encode([body]));

  if (response.statusCode == 201) {
    //Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    //user = User.fromJson(data);
  } else {
    throw Exception(
        'failed get ID ') ; //TODO exception handling...
  }

}

Future<void> addStepRecipe(num, contents, recipe_id, {img}) async {
  print("num : " + num);
  print("contents : " + contents);
  print("ingrd_id : " + recipe_id.toString());

  Map<String, dynamic> body = {
    "num": num,
    "contents": contents,
    "recipe_id": recipe_id
  };

  if(img != null) {
    final bytes = await Io.File(img!.path).readAsBytes();
    String img64 = base64Encode(bytes);
    body["img"] = img64;
  }

  final response = await http.post(Uri.parse(UrlPrefix.urls + "recipe/steps/add/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: json.encode([body]));

  if (response.statusCode == 201) {
    print("done");
    //Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    //user = User.fromJson(data);
  } else {
    throw Exception(
        'failed get ID ') ; //TODO exception handling...
  }
}

