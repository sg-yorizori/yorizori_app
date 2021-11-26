import 'package:flutter/material.dart';
import 'package:yorizori_app/User/profile.dart';

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
        body: Column(
          children: [
            SizedBox(
              height: height * 0.27,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: height * 0.18, child: profileRow(context)),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
