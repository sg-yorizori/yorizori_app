import 'package:flutter/material.dart';
import 'models/user.dart';

Widget profileRow(context, User user) {
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
            image: DecorationImage(
              image: user.profile_img == ''
                  ? AssetImage('assets/images/wink.png') as ImageProvider
                  : NetworkImage(user.profile_img),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(2, 4))
            ]),
      ),
      Container(
        child: Text(user.nick_name,
            style: //Theme.of(context).textTheme.headline5,
                TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white)),
      )
    ],
  );
  return profileRow;
}
