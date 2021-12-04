import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yorizori_app/Recipe/recipe.dart';
import 'package:yorizori_app/Home/home.dart';

class DataSearch extends SearchDelegate<String> {
  final ingred = [
    "사과",
    "바나나",
    "김치",
    "당근",
    "멸치",
    "마늘",
    "파",
  ];

  final recentIngred = [
    "김치",
    "당근",
    "멸치",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    //acktions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Container(
      height: 100,
      width: 100,
      child: Card(
        color: Colors.deepOrange,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentIngred
        : ingred.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.food_bank),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
