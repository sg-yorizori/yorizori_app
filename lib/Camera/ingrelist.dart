class IngreList {
  final String name;

  IngreList({required this.name});

  factory IngreList.fromJson(Map<String, dynamic> parsedJson) {
    return new IngreList(
      name: parsedJson["name"],
    );
  }
}
