import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;
//import 'package:yorizori_app/User/models/recipe.dart';
import 'package:yorizori_app/urls.dart';
import 'package:yorizori_app/sharedpref.dart';

Future<int> addMainRecipe(title,writer, {thumb}) async {
  var id;

  Map<String, dynamic> body = {
    "title": title,
    "writer": writer
  };

  if(thumb != null) {
    body["thumb"] = thumb;
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

void logout() async {
  try {
    String token = await getSharedPrefToken();
    final response = await http.post(
      Uri.parse(UrlPrefix.urls + 'users/logout/'),
      headers: <String, String>{
        'Authorization': "Token " + token,
      },
    );

    if (response.statusCode == 204) {
      print("logout sucecced");
    } else {
      throw Exception('falied logout');
    }
  } catch (e) {
    print(e);
  }
}

void profileUpadte(
    {new_nick_name, new_profile_image, new_disliked, new_vegan}) async {
  try {
    int user_id = await getSharedPrefUser();
    Map<String, dynamic> body = {
      "user_id": user_id,
    };

    if (new_nick_name != null) {
      body["nick_name"] = new_nick_name;
    }

    if (new_profile_image != null) {
      final bytes = await Io.File(new_profile_image!.path).readAsBytes();
      String img64 = base64Encode(bytes);
      body["profile_img"] = img64;
    }

    if (new_disliked != null) {
      body["disliked"] = new_disliked;
    }

    if (new_vegan != null) {
      body["vegan"] = new_vegan;
    }
    print(json.encode(body));
    final response =
    await http.post(Uri.parse(UrlPrefix.urls + 'users/profile/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body));

    if (response.statusCode == 200) {
      print("profile change sucecced");
    } else {
      throw Exception('falied profile change');
    }
  } catch (e) {
    print(e);
  }
}
