import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/detail.dart';
import 'package:yorizori_app/Camera/models/Recipe_one.dart';
import 'package:yorizori_app/User/list_view_UI.dart';
import 'package:yorizori_app/sharedpref.dart';
//import 'package:yorizori_app/User/models/recipe.dart';

class recentView extends StatefulWidget {
  List<Recipe_One> recent_view_list = [];
  recentView({Key? key, required this.recent_view_list}) : super(key: key);

  @override
  _recentViewState createState() => _recentViewState();
}

class _recentViewState extends State<recentView> {
  _fetch() async {
    List<int> saved_recent_view = await getSharedPrefList("recent_view");

    widget.recent_view_list =
        await getRecipeList(flag: 0, recipe_list: saved_recent_view);
    widget.recent_view_list = widget.recent_view_list.reversed.toList();

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    _fetch();
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
              itemCount: widget.recent_view_list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage2(
                                    widget.recent_view_list[index])))
                        .then((value) => _fetch());
                  },
                  child: Container(
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
                            backgroundImage:
                                widget.recent_view_list[index].thumb != ''
                                    // ? Image.network(
                                    //         widget.recent_view_list[
                                    //                 index]
                                    //             .thumb)
                                    //     as ImageProvider
                                    ? NetworkImage(
                                        widget.recent_view_list[index].thumb)
                                    : AssetImage('assets/images/wink.png')
                                        as ImageProvider,
                          ),
                          Text(
                            widget.recent_view_list[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: width * 0.028),
                          )
                        ],
                      )),
                );
              })),
    );
  }
}
