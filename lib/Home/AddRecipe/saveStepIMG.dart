import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yorizori_app/Home/AddRecipe/main_addRecipe.dart';


class pickStepImage extends StatefulWidget {
  Function step_img_setter;

  pickStepImage({Key? key, required this.step_img_setter})
      : super(key: key);

  @override
  _pickStepImageState createState() => _pickStepImageState();
}

class _pickStepImageState extends State<pickStepImage> {
  var step_image;

  @override
  void initState() {
    super.initState();
    //main_image = (widget.thumb != '')
    //    ? NetworkImage(widget.thumb)
    //    : AssetImage('assets/images/img_icon.png') as ImageProvider;
    step_image = AssetImage('assets/images/img_icon.PNG');
  }

  @override
  Widget build(BuildContext context) {
    var new_step_image;
    return Container(
      //alignment: Alignment.topCenter,
      height: 160,
      width: 160,
      child: Stack(children: [
        Container(
          //alignment: Alignment.topCenter,
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: step_image,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),

        Positioned(
          height: 30,
          child: FloatingActionButton(
            onPressed: () async {
              new_step_image = await getImageFromGallery();
              if (new_step_image != null) {
                setState(() {
                  step_image =
                      Image.file(File(new_step_image.path)).image;
                });
                widget.step_img_setter(new_step_image);
              }
            },
            shape: CircleBorder(
                side: BorderSide(
                    width: 2, color: Theme.of(context).primaryColor)),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.camera_enhance,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
          right: 0,
          left: 0.5,
          bottom: 0,
        ),
      ]),
    );
  }
}