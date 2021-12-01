class IngreList {
  final String name;

  IngreList({required this.name});

  factory IngreList.fromJson(Map<String, dynamic> parsedJson) {
    return new IngreList(
      name: parsedJson["name"],
    );
  }
}

class Ingredient {
  final int id;
  final String name;

  Ingredient({required this.id, required this.name});

  factory Ingredient.fromJson(Map<String, dynamic> parsedJson) {
    return new Ingredient(id: parsedJson["id"], name: parsedJson["name"]);
  }
}
