import 'package:shared_preferences/shared_preferences.dart';

Future<int> getSharedPrefUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int user_id = prefs.getInt("user_id") ?? 0;
  return user_id;
}

Future<String> getSharedPrefToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? '';
  return token;
}

Future<int> getSharedPrefVegan() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int user_vegan = prefs.getInt("vegan") ?? 0;
  return user_vegan;
}

void saveSharedPrefList(List<int> intList, String target) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> strList = intList.map((i) => i.toString()).toList();
  prefs.setStringList(target, strList);
}

Future<List<int>> getSharedPrefList(String target) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? savedStrList = prefs.getStringList(target) ?? [];
  List<int> intList = savedStrList.map((i) => int.parse(i)).toList();
  return intList;
}

void addSharedPrefList(int addValue, String target) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? savedStrList = prefs.getStringList(target) ?? [];
  List<int> intList = savedStrList.map((i) => int.parse(i)).toList();

  for (int i = 0; i < intList.length; i++) {
    if (addValue == intList[i]) {
      intList.removeAt(i);
    }
  }
  intList.add(addValue);
  if (intList.length > 5) {
    intList.removeAt(0);
  }
  print("recent_view");
  print(intList);
  List<String> strList = intList.map((i) => i.toString()).toList();
  prefs.setStringList(target, strList);
}

void setRecentView(int recipe_id) {
  addSharedPrefList(recipe_id, "recent_view");
}
