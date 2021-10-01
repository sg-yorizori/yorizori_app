import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import './camera.dart';
import './addtile.dart';

class Ingre {
  String name;

  Ingre(this.name);
}

List<Ingre> ingreList = [
  Ingre("Apple"),
  Ingre("Orange"),
  Ingre("Banana"),
  Ingre("Fish"),
  Ingre("Meat"),
  Ingre("Chicken")
];

class UsingBuilderListConstructing extends StatelessWidget {
  final VoidCallback flag_update;

  UsingBuilderListConstructing(this.flag_update);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: ingreList.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) return HeaderTile();
        if (index == ingreList.length + 1) return AddTile(flag_update);
        return IngreTile(ingreList[index - 1], flag_update);
      },
    );
  }
}

class IngreTile extends StatelessWidget {
  final Ingre _ingre;
  final VoidCallback flag_update;

  IngreTile(this._ingre, this.flag_update);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.food_bank),
        title: Text(_ingre.name),
        // subtitle: Text("${_ingre.age}"),
        trailing: IngreIcon(),
        onTap: () {
          ingreList.removeWhere((item) => item.name == _ingre.name);
          flag_update();
        });
  }
}

class HeaderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: image_cam == null
            ? Text('No image selected!!')
            : Image.file(File(image_cam!.path)),
      ),
    );
  }
}

class IngreIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.arrow_right);
  }
}