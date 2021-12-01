import 'package:flutter/material.dart';
import 'dart:io';
import './camera.dart';

// import './ingrelist.dart';

import 'package:yorizori_app/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondRoute extends StatefulWidget {
  final Function flag_update;
  SecondRoute(this.flag_update);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<String> add_list = [];
  final _InputController = TextEditingController();

  Future<List<String>> _getinput() async {
    return add_list;
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
        appBar: AppBar(
          title: const Text(
            "원하는 재료를 추가하세요.",
            style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(children: [
          SizedBox(
            height: 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 30,
              child: Icon(
                Icons.add_reaction_rounded,
                color: Colors.deepOrange,
                size: 30,
              ),
              // child: Image.asset('assets/images/title_image_1.png',
              //     fit: BoxFit.fill),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                '추가하고 싶은 재료를 입력하세요.',
                style: TextStyle(
                    color: Color(0xfffa4a0c),
                    fontSize: 20,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600),
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
                  controller: _InputController,
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
                    if (_InputController.text.isEmpty == true) return;

                    for (var i = 0; i < add_list.length; i++) {
                      if (add_list[i].compareTo(_InputController.text) == 0) {
                        return;
                      }
                    }
                    add_list.add(_InputController.text);
                  });
                },
                child: Text(
                  '추가',
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 19,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600),
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
                    children: buildAdds(add_list),
                  );
                }),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: Size(360, 40),
              primary: Color(0xfffa4a0c),
            ),
            onPressed: () {
              for (var i = 0; i < add_list.length; i++) {
                ingre_name_list.add(add_list[i]);
              }
              widget.flag_update();
              Navigator.pop(context);
            },
            child: Text(
              '완료!',
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> buildAdds(List<String> getAdds) {
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getAdds.length; i++) {
      list.add(buildAdd(getAdds[i], i));
      list.add(
        SizedBox(
          width: 10,
        ),
      );
    }
    return list;
  }

  Widget buildAdd(String add_one, int index) {
    return TextButton(
      style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
          backgroundColor: Colors.white,
          primary: Colors.deepOrangeAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        setState(() {
          add_list.removeWhere((item) => item == add_one);
        });
      },
      child: Text(add_one),
    );
  }
}
