import 'package:flutter/material.dart';

class DislikeList {
  final String name;

  DislikeList(this.name);
}

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
              onPressed: () {},
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
