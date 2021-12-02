import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yorizori_app/User/models/recipe.dart';
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
  List<Recipe> bookmark_list = [];
  List<Recipe> upload_list = [];

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
