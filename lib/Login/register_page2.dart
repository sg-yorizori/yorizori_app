import 'package:flutter/material.dart';

class MyRegister_2 extends StatefulWidget {
  const MyRegister_2({Key? key}) : super(key: key);

  @override
  _MyRegisterState_2 createState() => _MyRegisterState_2();
}

class _MyRegisterState_2 extends State<MyRegister_2> {
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
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  '이런 재료는 유의해주세요',
                  style: TextStyle(color: Color(0xfffa4a0c), fontSize: 15),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(13),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "재료",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: Size(20, 40),
                    primary: Color(0xfffa4a0c),
                  ),
                  onPressed: () {},
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 250),
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.all(13),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "test",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),

                          // ******
                          // controller: emailController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: Size(200, 40),
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
}
