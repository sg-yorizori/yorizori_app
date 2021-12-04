import 'package:flutter/material.dart';
import 'package:yorizori_app/User/user_setting/disliked.dart';
import 'package:yorizori_app/User/user_setting/vegan.dart';
import 'package:yorizori_app/sharedpref.dart';

Widget setDisliked(context, width, height, user_disliked) {
  // List<String> disliked_data = [
  //   '사과',
  //   '오렌쥐',
  //   '아아아',
  //   '아랄랄랄',
  //   '사과',
  //   '오렌쥐',
  //   '아아아',
  //   '아랄랄랄'
  // ];
  // var disliked = <Widget>[];
  // for (int i = 0; i < disliked_data.length; i++) {
  //   var ingrd = ElevatedButton(
  //     onPressed: () => {
  //       //disliked_data.removeWhere((item) => item == disliked_data[i])
  //     },
  //     child: Text(disliked_data[i]),
  //   );
  //   disliked.add(ingrd);
  // }
  return ExpansionTile(
    leading: Icon(Icons.warning),
    title: Text('이런 재료는 유의해주세요'),
    backgroundColor: Colors.white,
    childrenPadding: EdgeInsets.only(bottom: height * 0.015),
    children: [
      Divider(),
      Disliked(
        user_disliked: user_disliked,
      )
      // Wrap(spacing: width * 0.05, runSpacing: height * 0.01, children: disliked
      //     /*List.generate(
      //       8,
      //       (i) => Container(
      //             height: 30,
      //             width: 100,
      //             color: Colors.pink[(i + 1) * 100],
      //             child: Text(disliked[i]),
      //           )),*/
      //     ),
      // Container(
      //     height: height * 0.028,
      //     margin: EdgeInsets.only(bottom: height * 0.01),
      //     child: ElevatedButton(
      //       onPressed: () => {},
      //       child: Icon(
      //         Icons.add,
      //         size: 15,
      //       ),
      //       style: ElevatedButton.styleFrom(shape: CircleBorder()),
      //     ))
    ],
  );
}

Widget setVeganStage(context, width, height, user_vegan) {
  return ExpansionTile(
    leading: Icon(Icons.grass),
    title: Text('비건'),
    backgroundColor: Colors.white,
    children: [
      Container(
          padding: EdgeInsets.only(left: width * 0.05),
          alignment: Alignment.centerLeft,
          //height: height * 0.05,
          //margin: EdgeInsets.only(bottom: height * 0.015),
          child: Text(
            '어떤 음식까지 허용하시나요?',
            style: TextStyle(
              fontSize: width * 0.035,
              //color: Theme.of(context).primaryColor,
            ),
          )),
      //Text('TODO PUT Slider')
      Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.016),
        child: new VeganSlider(user_vegan: user_vegan),
      ),
    ],
  );
}

Widget changePasswd(context, width, height) {
  return ExpansionTile(
    backgroundColor: Colors.white,
    leading: Icon(Icons.vpn_key),
    title: Text('비밀번호 바꾸기'),
    children: [
      Row(
        children: [
          Flexible(
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: '기존 비밀번호'),
            ),
          ),
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () => {},
              icon: Icon(Icons.check))
        ],
      ),
    ],
  );
}

Widget deleteAccount(context, width, height) {
  return ExpansionTile(
    leading: Icon(Icons.delete),
    title: Text('계정 삭제하기'),
    backgroundColor: Colors.white,
    children: [
      Container(
          padding: EdgeInsets.all(height * 0.01), child: Text('계정을 삭제하시겠습니까?')),
      Padding(
        padding: EdgeInsets.all(height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade400)),
              child: Text(
                '앗 실수에요',
                //style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text('고마웠어, 안녕'),
            )
          ],
        ),
      )
    ],
  );
}
