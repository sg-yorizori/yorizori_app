import 'package:flutter/material.dart';
import 'package:yorizori_app/User/list_view_UI.dart';
import 'package:yorizori_app/User/models/recipe.dart';

Widget recentViewWidget(width, height, List<Recipe> recent_view_list) {
  return ScrollConfiguration(
    behavior: NoGlow(),
    child: Container(
        margin: EdgeInsets.only(bottom: height * 0.03),
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        height: 90,
        //color: Colors.grey,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: recent_view_list.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.018, horizontal: width * 0.035),
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundImage: recent_view_list[index].thumb != ''
                            // ? Image.network(
                            //         recent_view_list[
                            //                 index]
                            //             .thumb)
                            //     as ImageProvider
                            ? NetworkImage(recent_view_list[index].thumb)
                            : AssetImage('assets/images/wink.png')
                                as ImageProvider,
                      ),
                      Text(
                        recent_view_list[index].title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: width * 0.028),
                      )
                    ],
                  ));
            })),
  );
}
