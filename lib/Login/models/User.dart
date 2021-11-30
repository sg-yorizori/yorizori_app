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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['user_id'],
        json['nick_name'],
        json['profile_img'],
        json['vegan'],
        new List<int>.from(json['disliked']),
        new List<int>.from(json['bookmark']));
  }
}

Future<User> getUser(context, userId) async {
  User user;

  final response = await http.post(Uri.parse(UrlPrefix.urls + "users/profile/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"user_id": userId}));
  if (response.statusCode == 200) {
    // Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))[0];
    final data = json.decode(response.body);
    user = User.fromJson(data);
  } else {
    throw Exception(); //TODO exception handling...
  }

  return user;
}
