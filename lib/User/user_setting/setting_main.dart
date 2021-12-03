import 'package:flutter/material.dart';
import 'package:yorizori_app/User/models/step_unit.dart';
import 'package:yorizori_app/User/models/user.dart';
import 'package:yorizori_app/User/profile.dart';
import 'package:yorizori_app/User/user_setting/menu.dart';
import 'package:yorizori_app/User/user_setting/profileChange.dart';
import 'package:yorizori_app/main.dart';

class UserDetail extends StatefulWidget {
  Function mainRefresh;
  User user;
  UserDetail({Key? key, required this.user, required this.mainRefresh})
      : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  void initState() {
    super.initState();
    setIngrdNameList().then((value) {
      setState(() {});
    });
  }

  List<String> disliked = [];
  refreshData() async {
    // var update = await getUser(context, widget.user.user_id);
    // widget.user = update[0];
    var user = widget.mainRefresh();
    setState(() {
      widget.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    //setIngrdNameList();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context, true);
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
                  alignment: Alignment.bottomCenter,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    height: height * 0.15,
                    child: Stack(
                      children: [
                        profileRow(context, widget.user),

                        //프로필 수정하기
                        Positioned(
                          height: height * 0.043,
                          child: new ProfileChange(
                              user: widget.user, refresh: refreshData),
                          right: 0,
                          left: -width * 0.58,
                          bottom: height * 0.018,
                        ),
                      ],
                    ),
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
                    setDisliked(context, width, height, disliked),
                    Divider(),

                    setVeganStage(context, width, height, widget.user.vegan),
                    /*
                    Divider(),
                    changePasswd(context, width, height),
                    */
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.arrow_back),
                      title: Text("로그아웃"),
                      onTap: () {
                        logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => YorizoriAppAfterLogout(),
                            settings: RouteSettings(name: "/")));
                      },
                    ),
                    Divider(),
                    // deleteAccount(context, width, height),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  setIngrdNameList() async {
    disliked = await getIngrdNameList(widget.user.disliked);
  }
}
