import 'package:shared_preferences/shared_preferences.dart';

void saveRecentView(List<int> recentView) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> strList = recentView.map((i) => i.toString()).toList();
  prefs.setStringList("recentView", strList);
}

Future<List<int>> getRecentView() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? savedStrList = prefs.getStringList("recentView");
  List<int> recentView = savedStrList!.map((i) => int.parse(i)).toList();
  return recentView;
}
