import 'package:flutter/material.dart';
import './models/reg.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final _idController = TextEditingController();

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
              height: 100,
            ),
            Container(
              child: Text(
                '요리조리와 함께하기',
                style: TextStyle(color: Color(0xfffa4a0c), fontSize: 15),
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
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(13),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "아이디",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            controller: _idController,
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
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "비밀번호",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            controller: _passwordController,
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
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "비밀번호를 다시 입력해주세요",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            controller: _passwordCheckController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: Size(500, 40),
                              primary: Color(0xfffa4a0c),
                            ),
                            onPressed: () {
                              reg_id = _idController.text;

                              if (_passwordController.text ==
                                  _passwordCheckController.text) {
                                reg_pass = _passwordController.text;
                                Navigator.pushNamed(context, 'register2');
                              }
                            },
                            child: Text(
                              '다음',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 18,
                              ),
                            ),
                          ),
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
