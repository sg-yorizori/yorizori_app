import 'package:flutter/material.dart';
import 'package:yorizori_app/User/profile.dart';
import 'package:yorizori_app/User/user_setting/menu.dart';

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
                  alignment: Alignment.bottomCenter,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    height: height * 0.15,
                    child: Stack(
                      children: [
                        //profileRow(context,),
                        Positioned(
                          height: height * 0.043,
                          child: FloatingActionButton(
                            onPressed: () {},
                            shape: CircleBorder(
                                side: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor)),
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
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
                    setDisliked(context, width, height),
                    Divider(),
                    setVeganStage(context, width, height),
                    /*
                    Divider(),
                    changePasswd(context, width, height),
                    */
                    Divider(),
                    deleteAccount(context, width, height)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
