import 'package:flutter/material.dart';
import 'package:yorizori_app/Camera/camera.dart';
import 'package:yorizori_app/Camera/ingre_name_list.dart';

class CameraAlert extends StatefulWidget {
  final Function flag_update;
  CameraAlert(this.flag_update);

  @override
  _CameraAlertState createState() => _CameraAlertState();
}

// class _CameraState extends State<Camera> {

class _CameraAlertState extends State<CameraAlert> {
  // const CameraAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Container(
        // child: Text("되나~"),
        );
  }

  void showAlert(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "이렇게 찍어주세요",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              height: height * 0.37,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: AssetImage('assets/images/guide_image.png')),
                    // Image(image: AssetImage('assets/images/logo.png')),
                    Text(
                      "재료를 일렬로 나열한 후에 촬영해요.",
                      style: TextStyle(fontSize: 13),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //var new_profile_image = await getImageFromGallery();
                        // Navigator.pushNamed(context, 'camera');
                        route_flag.add(1);
                        widget.flag_update();
                        Navigator.pop(context);
                      },
                      child: Text("이해했어요"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
