import 'package:flutter/material.dart';

Widget profileRow(context, [edit = false]) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;
  var user_names = <Widget>[];
  Widget user_name = Text("User name",
      style: //Theme.of(context).textTheme.headline5,
          TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white));

  user_names.add(user_name);
  if (edit) {
    Widget name_edit = TextButton(
        onPressed: () => {print("clicked")},
        child: Text(
          '수정하기',
          style: TextStyle(color: Colors.white),
        ));
    user_names.add(name_edit);
  }

  Widget profileRow = Row(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.06),
        width: width * 0.17,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(2, 4))
            ]),
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: user_names,
      // )
      user_name
    ],
  );
  return profileRow;
}
