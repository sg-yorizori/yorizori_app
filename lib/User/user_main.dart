import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/detail.dart';
import 'package:yorizori_app/Camera/models/Recipe_one.dart';
import 'package:yorizori_app/User/list_view_UI.dart';
import 'package:yorizori_app/User/models/bookmark.dart';
import 'package:yorizori_app/User/recent_view.dart';
import 'package:yorizori_app/sharedpref.dart';
//import 'package:yorizori_app/User/models/recipe.dart';
import 'package:yorizori_app/User/profile.dart';
import 'package:yorizori_app/User/user_setting/setting_main.dart';

import 'models/user.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  var user;
  List<List<Recipe_One>> sub_recipe_list = [[], []];
  List<Recipe_One> user_bookmark_list = [];
  List<Recipe_One> user_upload_list = [];

  List<Recipe_One> recent_view_list = [];
  int? user_id;

  @override
  void initState() {
    super.initState();
    //saveSharedPrefList([2, 4, 8], "recent_view");
    // _initUser().whenComplete(() {
    //   setState(() {
    //     print("user_id" + user_id.toString());
    //   });
    // });
  }

  int menuSelected = 0;
  final items = List.generate(5, (index) => "list $index");

  // _initUser() async {
  //   this.user_id = await getSharedPrefUser();
  // }

  _fetch() async {
    List<int> saved_recent_view = await getSharedPrefList("recent_view");
    print("saved_recent_view");
    print(saved_recent_view);
    recent_view_list =
        await getRecipeList(flag: 1, recipe_list: saved_recent_view);
    recent_view_list = recent_view_list.reversed.toList();

    for (int i = 0; i < recent_view_list.length; i++) {
      print(recent_view_list[i].id);
    }
  }

  User refreshData() {
    setState(() {});
    return user;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    _fetch();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(_createRoute(user, refreshData))
                    .then((val) => val ? refreshData() : null);
              },
              icon: Icon(Icons.grid_view_rounded))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
          future: getSharedPrefUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Container(); //Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            user_id = snapshot.data as int?;
            return FutureBuilder(
                future: getUser(context, user_id),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return Container(); //Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  var data = snapshot.data;
                  user = data[0];
                  user_bookmark_list = data[1];

                  user_upload_list = data[2];
                  sub_recipe_list = [user_bookmark_list, user_upload_list];

                  return Column(
                    children: [
                      SizedBox(
                        width: width,
                        height: height * 0.42,
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  height: height * 0.15,
                                  width: width,
                                  child: profileRow(context, user)),
                              Container(
                                height: height * 0.03,
                                margin: EdgeInsets.only(
                                    left: width * 0.06, bottom: 5),
                                //color: Colors.grey,
                                child: Row(
                                  children: [
                                    Text(
                                      '👀 최근 본 레시피',
                                      style: TextStyle(
                                          fontSize: width * 0.037,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.007,
                              ),
                              recentViewWidget(width, height, recent_view_list)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: width * 0.07,
                            left: width * 0.07,
                            top: height * 0.03),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    (menuSelected == 0)
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    size: width * 0.06,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      menuSelected = 0;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    (menuSelected == 0)
                                        ? Icons.folder_outlined
                                        : Icons.folder,
                                    size: width * 0.06,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      menuSelected = 1;
                                    });
                                  },
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.2,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                padding: EdgeInsets.only(
                                    top: 0,
                                    left: width * 0.06,
                                    right: width * 0.06),
                                itemCount: sub_recipe_list[menuSelected].length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: Key(sub_recipe_list[menuSelected]
                                            [index]
                                        .title),
                                    onDismissed: (direction) {
                                      setState(() {
                                        deletBookmarkOrMyRecipe(
                                            menuSelected,
                                            sub_recipe_list[menuSelected][index]
                                                .id);

                                        sub_recipe_list[menuSelected]
                                            .removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                blurRadius: 4,
                                                offset: Offset(2, 4))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage2(
                                                          sub_recipe_list[
                                                                  menuSelected]
                                                              [index])));
                                        },
                                        title: Text(
                                            sub_recipe_list[menuSelected][index]
                                                .title,
                                            overflow: TextOverflow.ellipsis),
                                        subtitle: Text(
                                            sub_recipe_list[menuSelected][index]
                                                    .views
                                                    .toString() +
                                                " views"),
                                        leading:
                                            //ExpandedImage
                                            CircleAvatar(
                                          radius: width * 0.08,
                                          backgroundImage: (sub_recipe_list[
                                                          menuSelected][index]
                                                      .thumb !=
                                                  '')
                                              // ? Image.network(
                                              //     sub_recipe_list[menuSelected][index]
                                              //         .thumb) as ImageProvider
                                              ? NetworkImage(
                                                  sub_recipe_list[menuSelected]
                                                          [index]
                                                      .thumb)
                                              : AssetImage(
                                                      'assets/images/wink.png')
                                                  as ImageProvider,
                                        ),
                                      ),
                                    ),
                                    background: Container(
                                      padding: EdgeInsets.all(20),
                                      alignment: Alignment.centerRight,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          )),
                                    ),
                                  );
                                })),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}

Route _createRoute(user, refresh) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          UserDetail(user: user, mainRefresh: refresh),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
