import 'package:flutter/material.dart';
import 'package:yorizori_app/User/profile.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.27,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: height * 0.18, child: profileRow(context)),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Column(
                  children: [
                    ExpansionTile(
                      leading: Icon(Icons.warning),
                      title: Text('이런 재료는 유의해주세요'),
                      backgroundColor: Colors.white,
                      children: [Divider(), Text('TODO LIST FOODS')],
                    ),
                    Divider(),
                    ExpansionTile(
                      leading: Icon(Icons.grass),
                      title: Text('비건'),
                      backgroundColor: Colors.white,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: width * 0.03),
                            alignment: Alignment.centerLeft,
                            height: height * 0.03,
                            child: Text(
                              '어떤 음식까지 허용하시나요?',
                              style: TextStyle(fontSize: width * 0.028),
                            )),
                        Text('TODO PUT Slider')
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      backgroundColor: Colors.white,
                      leading: Icon(Icons.vpn_key),
                      title: Text('비밀번호 바꾸기'),
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: TextField(
                                obscureText: true,
                                decoration:
                                    InputDecoration(labelText: '기존 비밀번호'),
                              ),
                            ),
                            IconButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () => {},
                                icon: Icon(Icons.check))
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    ExpansionTile(
                      leading: Icon(Icons.delete),
                      title: Text('계정 삭제하기'),
                      children: [
                        Container(
                            padding: EdgeInsets.all(height * 0.01),
                            child: Text('계정을 삭제하시겠습니까?')),
                        Padding(
                          padding: EdgeInsets.all(height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () => {},
                                child: Text('앗 실수에요'),
                              ),
                              ElevatedButton(
                                onPressed: () => {},
                                child: Text('고마웠어, 안녕'),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
