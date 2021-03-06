import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorizori_app/Camera/models/Recipe_one.dart';
import 'dart:io' as Io;
//import 'package:yorizori_app/User/models/recipe.dart';
import 'package:yorizori_app/urls.dart';
import 'package:yorizori_app/sharedpref.dart';

class User {
  int user_id;
  String nick_name;
  String profile_img;
  int vegan;

  List<int> disliked;
  List<int> bookmark;

  User(this.user_id, this.nick_name, this.profile_img, this.vegan,
      this.disliked, this.bookmark);

  User.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        nick_name = json['nick_name'],
        profile_img = json['profile_img'],
        vegan = json['vegan'],
        disliked = new List<int>.from(json['disliked']),
        bookmark = new List<int>.from(json['bookmark']);
}

Future<List<dynamic>> getUser(context, userId) async {
  var user;
  List<Recipe_One> bookmark_list = [];
  List<Recipe_One> upload_list = [];

  final response = await http.post(Uri.parse(UrlPrefix.urls + "users/profile/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"user_id": userId}));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    user = User.fromJson(data);

    if (user.bookmark.length != 0)
      bookmark_list = await getRecipeList(flag: 1, recipe_list: user.bookmark);

    upload_list = await getRecipeList(user_id: userId);

    saveSharedPrefList(user.bookmark, 'bookmark');
    saveSharedPrefList(user.disliked, 'disliked');
  } else {
    throw Exception(
        'failed get User ' + userId.toString()); //TODO exception handling...
  }

  return [user, bookmark_list, upload_list];
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      prefs.setInt('vegan', new_vegan);
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
