import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yorizori_app/urls.dart';

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

Future<User> getUser(context, userId) async {
  User user;

  final response = await http.post(Uri.parse(UrlPrefix.urls + "users/profile/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"user_id": userId}));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))[0];

    user = User.fromJson(data);
  } else {
    throw Exception(); //TODO exception handling...
  }

  return user;
}
