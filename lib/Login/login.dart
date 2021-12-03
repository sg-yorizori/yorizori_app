import 'package:flutter/material.dart';
import 'package:yorizori_app/urls.dart';
import 'dart:convert';
import './test.dart';
import 'package:http/http.dart' as http;
import './models/TokenReceiver.dart';

import 'package:yorizori_app/User/models/user.dart';
// import './models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:yorizori_app/sharedpref.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  var _id;
  var _pass;
  var _isLoading;

  userLogin() async {
    final response = await http.post(
      Uri.parse(UrlPrefix.urls + "users/login/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "username": _id,
        "password": _pass,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && mounted) {
        setState(() {
          _isLoading = false;
        });
        // print("login true!!");

        TokenReceiver myToken = TokenReceiver.fromJson(data);
        int id = await idGet(myToken.token);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', myToken.token);
        prefs.setInt('user_id', id);

        // User myUser = await getUser(context, id);
        // getUser(context, id);

        var user;

        final response =
            await http.post(Uri.parse(UrlPrefix.urls + "users/profile/"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode({"user_id": id}));
        if (response.statusCode == 200) {
          Map<String, dynamic> data =
              jsonDecode(utf8.decode(response.bodyBytes));
          user = User.fromJson(data);
        } else {
          throw Exception('failed get User ' + id.toString());
        }

        saveSharedPrefList(user.bookmark, 'bookmark');
        saveSharedPrefList(user.disliked, 'disliked');
        prefs.setString('nick_name', user.nick_name);

        print("LogIn Success");
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        print(sharedPreferences.getString("token"));
        print(sharedPreferences.getInt("user_id"));
        print(sharedPreferences.getString("nick_name"));
        print(sharedPreferences.getStringList("bookmark"));
        print("!!!!");
        print(sharedPreferences.getStringList("disliked"));

        Navigator.pushNamed(context, 'mainpage');
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print("login false");
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        // body: Stack(
        body: Column(
          children: [
            // Container(),
            SizedBox(
              height: 60,
            ),
            Container(
                width: 200,
                // margin: EdgeInsets.all(10),
                // padding: EdgeInsets.all(5),
                child: Image.asset('assets/images/logo.png', fit: BoxFit.fill)),
            SizedBox(
              height: 10,
            ),
            Container(
              // margin: EdgeInsets.all(100),
              // padding: EdgeInsets.only(
              //     top: MediaQuery.of(context).size.height * 0.5),
              child: Text(
                '요리조리 레시피를 찾아볼까요',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                // padding: EdgeInsets.only(
                //     top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 55, right: 55),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(13),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "아이디",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            // ******
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(13),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "비밀번호",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            // ******
                            controller: passwordController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: Size(500, 50),
                              primary: Color(0xffa52d2d),
                            ),
                            onPressed: () {
                              // Navigator.pushNamed(context, 'mainpage');

                              _id = emailController.text;
                              _pass = passwordController.text;

                              // print(_id);
                              // print(_pass);
                              userLogin();
                            },
                            child: Text(
                              '시작하기',
                              style: TextStyle(
                                  // decoration: TextDecoration.underline,
                                  color: Color(0xffffffff),
                                  fontSize: 19,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  '요리조리와 함께하기',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      color: Color(0xffffffff),
                                      fontSize: 17,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
