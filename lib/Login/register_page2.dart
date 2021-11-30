import 'package:flutter/material.dart';
import './register_page1.dart';

import 'package:yorizori_app/urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './models/reg.dart';
import './models/TokenReceiver.dart';

class MyRegister_2 extends StatefulWidget {
  const MyRegister_2({Key? key}) : super(key: key);

  @override
  _MyRegisterState_2 createState() => _MyRegisterState_2();
}

class _MyRegisterState_2 extends State<MyRegister_2> {
  List<String> dislike_list = [];
  final _dislikeController = TextEditingController();
  var i = 0;
  double d = 0;

  int vegan = 0;

  userRegister() async {
    final response = await http.post(
      Uri.parse(UrlPrefix.urls + "users/register/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "username": reg_id,
        "password": reg_pass,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && mounted) {
        print("register success");

        TokenReceiver myToken = TokenReceiver.fromJson(data);
        int id = await idGet(myToken.token);
        print(id);
        prof_user_id = id;
        // ****
        // userProfile();
      }
    } else {
      print("register fail");
      print(response.body);
    }
  }

  userProfile() async {
    print("!@!!");
    print(prof_user_id);
    print(dislike_list);
    print(vegan);
    final response = await http.post(
      Uri.parse(UrlPrefix.urls + "users/profile/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "nick_name": "테스트용",
        "user_id": prof_user_id,
        "disliked": dislike_list,
        "vegan": vegan
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && mounted) {
        print("profile success");
        Navigator.pushNamed(context, 'mainpage');
      }
    } else {
      print("profile fail");
      print(response.body);
    }
  }

  Future<int> idGet(String token) async {
    String knoxToken = 'Token ' + token;
    final response = await http.get(
      Uri.parse(UrlPrefix.urls + "users/user/"),
      headers: <String, String>{
        'Authorization': knoxToken,
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['id'];
    } else {
      throw Exception();
    }
  }

  Future<List<String>> _getinput() async {
    return dislike_list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Container(),
            SizedBox(
              height: 80,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 30,
                child: Image.asset('assets/images/title_image_1.png',
                    fit: BoxFit.fill),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  '이런 재료는 유의해주세요',
                  style: TextStyle(color: Color(0xfffa4a0c), fontSize: 18),
                ),
              ),
            ]),

            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                color: Color(0xfffa4a0c),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 1.5,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "재료",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    controller: _dislikeController,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: Size(0, 40),
                    primary: Color(0xfffa4a0c),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_dislikeController.text.isEmpty == true) return;

                      for (var i = 0; i < dislike_list.length; i++) {
                        if (dislike_list[i]
                                .compareTo(_dislikeController.text) ==
                            0) {
                          return;
                        }
                      }

                      dislike_list.add(_dislikeController.text);
                    });
                  },
                  child: Text(
                    '추가',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 16, left: 20),
              decoration: BoxDecoration(
                color: Color(0xffe3e3e3),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 55,
              child: FutureBuilder(
                  future: _getinput(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListView(
                      padding: EdgeInsets.only(left: 2, bottom: 5, top: 5),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: buildDislikes(dislike_list),
                    );
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 30,
                child: Image.asset('assets/images/title_image_2.png',
                    fit: BoxFit.fill),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  '비건',
                  style: TextStyle(color: Color(0xfffa4a0c), fontSize: 18),
                ),
              ),
            ]),

            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                color: Color(0xfffa4a0c),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 1.5,
            ),
            SizedBox(
              height: 5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 16, left: 20),
                child: Text(
                  '어떤 음식까지 허용하시나요?',
                  style: TextStyle(color: Color(0xfffa4a0c), fontSize: 15),
                ),
              ),
            ]),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                color: Color(0xffe3e3e3),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 55,
              child: Stack(children: [
                Container(),
                Positioned(
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Color(0xfff3d9d0),
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // width: i == 0 ? 0 : i * 50 + 7.5,
                    width: d,
                    height: 55,
                  ),
                ),
                Positioned(
                  top: 5,
                  bottom: 5,
                  left: 10,
                  child: Container(
                    width: 40,
                    height: 50,
                    // color: Color(0xffe3e3e3),
                    child: InkWell(
                      child: Image.asset('assets/images/icon1.png'),
                      onTap: () {
                        setState(() {
                          vegan = 1;
                          i = 1;
                          d = 50 * i + 7.5;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  bottom: 5,
                  left: 60,
                  child: Container(
                    width: 40,
                    height: 50,
                    child: InkWell(
                      child: Image.asset('assets/images/icon2.png'),
                      onTap: () {
                        setState(() {
                          vegan = 2;
                          i = 2;
                          d = 50 * i + 7.5;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  bottom: 5,
                  left: 110,
                  child: Container(
                    width: 40,
                    height: 50,
                    child: InkWell(
                      child: Image.asset('assets/images/icon3.png'),
                      onTap: () {
                        setState(() {
                          vegan = 3;
                          i = 3;
                          d = 50 * i + 7.5;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  bottom: 5,
                  left: 160,
                  child: Container(
                    width: 40,
                    height: 50,
                    child: InkWell(
                      child: Image.asset('assets/images/icon4.png'),
                      onTap: () {
                        setState(() {
                          vegan = 4;
                          i = 4;
                          d = 50 * i + 7.5;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  bottom: 5,
                  left: 210,
                  child: Container(
                    width: 40,
                    height: 50,
                    child: InkWell(
                      child: Image.asset('assets/images/icon5.png'),
                      onTap: () {
                        setState(() {
                          vegan = 5;
                          i = 5;
                          d = 50 * i + 7.5;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  bottom: 5,
                  left: 260,
                  child: Container(
                    width: 40,
                    height: 50,
                    child: InkWell(
                      child: Image.asset('assets/images/icon6.png'),
                      onTap: () {
                        setState(() {
                          vegan = 6;
                          i = 6;
                          d = 50 * i + 7.5;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  bottom: 5,
                  left: 310,
                  child: Container(
                    width: 40,
                    height: 50,
                    child: InkWell(
                      child: Image.asset('assets/images/icon7.png'),
                      onTap: () {
                        setState(() {
                          vegan = 7;
                          i = 7;
                          d = 50 * i + 20;
                        });
                      },
                    ),
                  ),
                ),
              ]),
            ),

            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: Size(380, 40),
                primary: Color(0xfffa4a0c),
              ),
              onPressed: () {
                userRegister();
              },
              child: Text(
                '끝',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildDislikes(List<String> getDislikes) {
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getDislikes.length; i++) {
      list.add(buildDislike(getDislikes[i], i));
      list.add(
        SizedBox(
          width: 10,
        ),
      );
    }
    return list;
  }

  Widget buildDislike(String dislike_one, int index) {
    return TextButton(
      style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
          backgroundColor: Colors.white,
          primary: Colors.deepOrangeAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        setState(() {
          dislike_list.removeWhere((item) => item == dislike_one);
        });
      },
      child: Text(dislike_one),
      // child: const Text("Hi"),
    );
  }
}
