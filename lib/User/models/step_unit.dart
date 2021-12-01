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
