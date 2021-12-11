import 'package:yorizori_app/Home/AddRecipe/main_addRecipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class pickMainImage extends StatefulWidget {
  Function main_img_setter;

  pickMainImage({Key? key, required this.main_img_setter})
      : super(key: key);

  @override
  _pickMainImageState createState() => _pickMainImageState();
}

class _pickMainImageState extends State<pickMainImage> {
  var main_image;
  @override
  void initState() {
    super.initState();
    //main_image = (widget.thumb != '')
    //    ? NetworkImage(widget.thumb)
    //    : AssetImage('assets/images/img_icon.png') as ImageProvider;
    main_image = AssetImage('assets/images/img_icon.PNG');
  }

  @override
  Widget build(BuildContext context) {
    var new_main_image;
    return Container(
      //alignment: Alignment.topCenter,
      height: 310,
      width: 410,
      child: Stack(children: [
        Container(
          //alignment: Alignment.topCenter,
          height: 310,
          width: 410,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: main_image,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),

        Positioned(
          height: 30,
          child: FloatingActionButton(
            onPressed: () async {
              new_main_image = await getImageFromGallery();
              if (new_main_image != null) {
                setState(() {
                  main_image =
                      Image.file(File(new_main_image.path)).image;
                });
                widget.main_img_setter(new_main_image);
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