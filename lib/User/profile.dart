import 'package:flutter/material.dart';

Widget profileRow(context) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;

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
      Text("User name",
          style: //Theme.of(context).textTheme.headline5,
              TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white))
    ],
  );
  return profileRow;
}
