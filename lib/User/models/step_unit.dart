import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yorizori_app/urls.dart';

class Step {
  int num;
  String contents;
  String img;

  Step(this.num, this.contents, this.img);

  Step.fromJson(Map<String, dynamic> json)
      : num = json['num'],
        contents = json['contents'],
        img = json['img'];
}

class Unit {
  String ingrd_name;
  String unit;

  Unit(this.ingrd_name, this.unit);

  Unit.fromJson(Map<String, dynamic> json)
      : ingrd_name = json['ingrd_name'],
        unit = json['unit'];
}

List<Step> parseStepList(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Step>((json) => Step.fromJson(json)).toList();
}

List<Unit> parseUnitList(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Unit>((json) => Unit.fromJson(json)).toList();
}

Future<List<Step>> getStepList(recipe_id) async {
  List<Step> stepList = [];
  try {
    final response = await http.get(
        Uri.parse(UrlPrefix.urls + 'recipe/steps/all/' + recipe_id.toString()));

    if (response.statusCode == 200) {
      stepList = parseStepList(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('falied get step list with ' + recipe_id.toString());
    }
  } catch (e) {
    print(e);
  }
  return stepList;
}

Future<List<Unit>> getUnitList(recipe_id) async {
  List<Unit> unitList = [];
  try {
    final response = await http.get(
        Uri.parse(UrlPrefix.urls + 'recipe/unit/all/' + recipe_id.toString()));

    if (response.statusCode == 200) {
      unitList = parseUnitList(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('falied get unit list with ' + recipe_id.toString());
    }
  } catch (e) {
    print(e);
  }
  return unitList;
}

class Ingrd {
  int id;
  String name;
  Ingrd(this.id, this.name);
  Ingrd.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

Future<List<String>> parsedIngrdList(String responseBody) async {
  List<String> ingrdNameList = [];
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  List<Ingrd> IngrdList =
      parsed.map<Ingrd>((json) => Ingrd.fromJson(json)).toList();
  for (int i = 0; i < IngrdList.length; i++) {
    ingrdNameList.add(IngrdList[i].name);
  }
  return ingrdNameList;
}

Future<List<String>> getIngrdNameList(List<int> ingrdIdList) async {
  List<String> ingrdNameList = [];
  try {
    final response =
        await http.post(Uri.parse(UrlPrefix.urls + 'recipe/ingrd/all/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({"flag": 2, "ingrd_List": ingrdIdList}));

    if (response.statusCode == 200) {
      ingrdNameList = await parsedIngrdList(utf8.decode(response.bodyBytes));
      // print(ingrdNameList);
    } else {
      throw Exception('falied get Ingrd Name List');
    }
  } catch (e) {
    print(e);
  }
  return ingrdNameList;
}
