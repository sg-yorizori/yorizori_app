import 'package:flutter/material.dart';
import 'dart:io';
import './camera.dart';

import './ingrelist.dart';

class AddItem {
  String name;

  AddItem(this.name);
}

List<AddItem> ItemList = [
  AddItem("a"),
  AddItem("b"),
  AddItem("c"),
  AddItem("d"),
  AddItem("e"),
  AddItem("f")
];

class SecondRoute extends StatelessWidget {
  final VoidCallback flag_update;

  SecondRoute(this.flag_update);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("원하는 재료를 추가하세요."),
      ),
      body: BodyLayout(flag_update),
    );
  }
}

class BodyLayout extends StatelessWidget {
  final VoidCallback flag_update;

  BodyLayout(this.flag_update);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: ItemList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: Icon(Icons.food_bank),
            title: Text(ItemList[index].name),
            subtitle: Text("test"),
            trailing: Icon(Icons.food_bank_sharp),
            onTap: () {
              ingre_list.add(IngreList(name: ItemList[index].name));
              flag_update();
              Navigator.pop(context);
            });
      },
    );
  }
}
