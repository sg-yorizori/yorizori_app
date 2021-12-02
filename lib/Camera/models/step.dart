import 'dart:convert';

class Step_detail {
  int id;
  int num;
  String contents;
  String img;
  int recipe_id;

  Step_detail(this.id, this.num, this.contents, this.img, this.recipe_id);

  // Step.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       created_date = DateTime.parse(json['created_date']),
  //       views = json['views'],
  //       thumb = json['thumb'],
  //       writer = json['writer'];
}
