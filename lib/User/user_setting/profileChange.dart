import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yorizori_app/User/models/user.dart';

class ProfileChange extends StatelessWidget {
  User user;
  late double width, height;
  var _formKey;
  var newName;
  var new_profile_image;
  Function refresh;

  ProfileChange({Key? key, required this.user, required this.refresh})
      : super(key: key);

  setter(img) {
    new_profile_image = img;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    width = screenSize.width;
    height = screenSize.height;
    _formKey = GlobalKey<FormState>();
    newName = TextEditingController(text: user.nick_name);
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                // alignment: Alignment.center,
                // titleTextStyle: TextStyle(),
                title: Text(
                  "프로필 변경하기",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                content: SizedBox(
                  height: height * 0.25,
                  width: width * 0.7,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        new pickProfileImage(
                          user: user,
                          setter: setter,
                        ),
                        TextFormField(
                          controller: newName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '변경할 프로필 이름을 입력하세요.';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(labelText: '프로필 이름'),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("취소")),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            (newName.text != user.nick_name ||
                                new_profile_image != null)) {
                          _formKey.currentState!.save();
                          profileUpadte(
                              new_nick_name: newName.text,
                              new_profile_image: new_profile_image);
                          refresh();
                          Navigator.pop(context);
                        }
                      },
                      child: Text("확인"))
                ],
              );
            }).then((value) {
          refresh();
        });
      },
      shape: CircleBorder(
          side: BorderSide(width: 2, color: Theme.of(context).primaryColor)),
      backgroundColor: Colors.white,
      child: Icon(
        Icons.edit,
        size: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

Future<XFile?> getImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  var image = await _picker.pickImage(source: ImageSource.gallery);
  return image;
}

class pickProfileImage extends StatefulWidget {
  Function setter;
  User user;
  pickProfileImage({Key? key, required this.user, required this.setter})
      : super(key: key);

  @override
  _pickProfileImageState createState() => _pickProfileImageState();
}

class _pickProfileImageState extends State<pickProfileImage> {
  var profile_image;
  @override
  void initState() {
    super.initState();
    profile_image = (widget.user.profile_img != '')
        ? NetworkImage(widget.user.profile_img)
        //Image.network(user.profile_img) as ImageProvider
        : AssetImage('assets/images/wink.png') as ImageProvider;
  }

  @override
  Widget build(BuildContext context) {
    var new_profile_image;
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      width: width * 0.5,
      height: height * 0.13,
      alignment: Alignment.center,
      child: Stack(children: [
        CircleAvatar(radius: width * 0.08, backgroundImage: profile_image),
        Positioned(
          height: height * 0.043,
          child: FloatingActionButton(
            onPressed: () async {
              new_profile_image = await getImageFromGallery();
              if (new_profile_image != null) {
                setState(() {
                  profile_image =
                      Image.file(File(new_profile_image.path)).image;
                });
                widget.setter(new_profile_image);
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
          left: width * 0.1,
          bottom: -height * 0.001,
        ),
      ]),
    );
  }
}
