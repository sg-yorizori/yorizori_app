import 'package:shared_preferences/shared_preferences.dart';

Future<List<int>> getSharedPopularList(String target) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? savedStrList = prefs.getStringList(target) ?? [];
  List<int> intList = savedStrList.map((i) => int.parse(i)).toList();
  return intList;
}