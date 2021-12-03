import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yorizori_app/sharedpref.dart';
import 'package:yorizori_app/urls.dart';

void deletBookmarkOrMyRecipe(int menu, int recipe_id) async {
  if (menu == 0) {
    try {
      int user_id = await getSharedPrefUser();
      final response =
          await http.delete(Uri.parse(UrlPrefix.urls + 'recipe/bookmark/'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({"user_id": user_id, "recipe_id": recipe_id}));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        List<int> bookmark = data['bookmark'].cast<int>();
        saveSharedPrefList(bookmark, 'bookmark');
        print("deleted bookmark : recipe id " + recipe_id.toString());
      } else {
        throw Exception('falied delete bookmark');
      }
    } catch (e) {
      print(e);
    }
  } else {
    try {
      final response = await http.delete(
          Uri.parse(UrlPrefix.urls + 'recipe/' + recipe_id.toString() + '/'));
      if (response.statusCode == 204) {
        print("deleted recipe : recipe id " + recipe_id.toString());
      } else {
        throw Exception('falied delete recipe');
      }
    } catch (e) {
      print(e);
    }
  }
}

void updateVeganStage(vegan_stage) async {
  try {
    int user_id = await getSharedPrefUser();
    final response =
        await http.delete(Uri.parse(UrlPrefix.urls + 'users/profile/update'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({"user_id": user_id, "vegan": vegan_stage}));
    if (response.statusCode == 204) {
      print("updated vegan stage");
    } else {
      throw Exception('falied vegan stage');
    }
  } catch (e) {
    print(e);
  }
}
