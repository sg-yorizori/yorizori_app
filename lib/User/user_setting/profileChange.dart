import 'package:flutter/material.dart';
import 'package:yorizori_app/User/models/user.dart';

void showProfileChange(context, User user) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;
  double height = screenSize.height;
  final _formKey = GlobalKey<FormState>();
  final newName = TextEditingController(text: user.nick_name);

  showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
                  Container(
                    width: width * 0.5,
                    height: height * 0.13,
                    alignment: Alignment.center,
                    child: Stack(children: [
                      CircleAvatar(
                        radius: width * 0.08,
                        backgroundImage: (user.profile_img != '')
                            ? NetworkImage(user.profile_img)
                            : AssetImage('assets/images/wink.png')
                                as ImageProvider,
                      ),
                      Positioned(
                        height: height * 0.043,
                        child: FloatingActionButton(
                          onPressed: () {}, //TODO 이미지
                          shape: CircleBorder(
                              side: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor)),
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
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      newName.text != user.nick_name) {
                    _formKey.currentState!.save();
                    print(_formKey.currentState.toString());
                    print("잘해쓰");
                    //TODO 프로필 수정 request
                    Navigator.pop(context);
                  }
                },
                child: Text("확인"))
          ],
        );
      });
}
