import 'package:flutter/material.dart';
import 'package:yorizori_app/User/profile.dart';
import 'package:yorizori_app/User/user_detail.dart';

class User extends StatefulWidget {
  User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  int menuSelected = 0;
  final items = List.generate(10, (index) => "list $index");

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    List<Widget> bookmark = [
      Icon(
        Icons.favorite,
        size: width * 0.06,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.favorite_outline,
        size: width * 0.06,
        color: Theme.of(context).primaryColor,
      )
    ];

    List<Widget> wrote = [
      Icon(
        Icons.folder_outlined,
        size: width * 0.06,
        color: Theme.of(context).primaryColor,
      ),
      Icon(
        Icons.folder,
        size: width * 0.06,
        color: Theme.of(context).primaryColor,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              icon: Icon(Icons.grid_view_rounded))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
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
                  //TODO profileRow에 user 이름, 이미지 정보
                  SizedBox(height: height * 0.18, child: profileRow(context)),
                  Container(
                    height: height * 0.03,
                    margin: EdgeInsets.only(left: width * 0.05, bottom: 5),
                    //color: Colors.grey,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          child: Text('.'),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          child: Text('.'),
                        )
                      ],
                    ),
                  ),
                  ScrollConfiguration(
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
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://cdn.ppomppu.co.kr/zboard/data3/2018/0509/m_1525850138_3126_1516635001428.jpg"),
                                      ),
                                      Text(items[index])
                                    ],
                                  ));
                            })
                        /*Row(
                        //TODO 최근 본 레시피
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: Offset(2, 4))
                                ]),
                          )
                        ],
                      ),*/
                        ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: width * 0.07, left: width * 0.07, top: height * 0.03),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: bookmark[menuSelected],
                      onPressed: () {
                        setState(() {
                          menuSelected = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: wrote[menuSelected],
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
                      top: 0, left: width * 0.06, right: width * 0.06),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(items[index]),
                      onDismissed: (direction) {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: Offset(2, 4))
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(items[index]),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://cdn.ppomppu.co.kr/zboard/data3/2018/0509/m_1525850138_3126_1516635001428.jpg"),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                      background: Container(
                        // decoration: BoxDecoration(
                        //     color: Colors.grey.shade200,
                        //     borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            )), //Text("delete")
                        /*decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle)*/
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UserDetail(),
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

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
