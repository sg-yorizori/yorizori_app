//from login/register_page2.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorizori_app/User/models/user.dart';
import 'package:yorizori_app/sharedpref.dart';

class VeganSlider extends StatefulWidget {
  int user_vegan;
  VeganSlider({Key? key, required this.user_vegan}) : super(key: key);

  @override
  _VeganSliderState createState() => _VeganSliderState();
}

class _VeganSliderState extends State<VeganSlider> {
  var i = 0;
  double sliderWidth = 0;
  int vegan = 0;

  @override
  void initState() {
    super.initState();
    vegan = widget.user_vegan;
    setSlider(vegan);
  }

  setSlider(index) {
    vegan = index;
    sliderWidth = 50 * vegan + 7.5;
    // print("$vegan, $sliderWidth");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            //margin: EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
              color: Color(0xffe3e3e3),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 55,
            child: Stack(children: [
              Container(),
              Positioned(
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Color(0xfff3d9d0),
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // width: i == 0 ? 0 : i * 50 + 7.5,
                  width: sliderWidth,
                  height: 55,
                ),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                left: 10,
                child: Container(
                  width: 40,
                  height: 50,
                  // color: Color(0xffe3e3e3),
                  child: InkWell(
                    child: Image.asset('assets/images/icon1.png'),
                    onTap: () {
                      setSlider(1);
                      setState(() {
                        vegan = 1;
                        sliderWidth = 50 * vegan + 7.5;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                left: 60,
                child: Container(
                  width: 40,
                  height: 50,
                  child: InkWell(
                    child: Image.asset('assets/images/icon2.png'),
                    onTap: () {
                      setState(() {
                        vegan = 2;
                        sliderWidth = 50 * vegan + 7.5;
                        setSlider(2);
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                left: 110,
                child: Container(
                  width: 40,
                  height: 50,
                  child: InkWell(
                    child: Image.asset('assets/images/icon3.png'),
                    onTap: () {
                      setState(() {
                        vegan = 3;
                        sliderWidth = 50 * vegan + 7.5;
                        setSlider(3);
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                left: 160,
                child: Container(
                  width: 40,
                  height: 50,
                  child: InkWell(
                    child: Image.asset('assets/images/icon4.png'),
                    onTap: () {
                      setState(() {
                        vegan = 4;
                        sliderWidth = 50 * vegan + 7.5;
                        setSlider(4);
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                left: 210,
                child: Container(
                  width: 40,
                  height: 50,
                  child: InkWell(
                    child: Image.asset('assets/images/icon5.png'),
                    onTap: () {
                      setState(() {
                        vegan = 5;
                        sliderWidth = 50 * vegan + 7.5;
                        setSlider(5);
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                left: 260,
                child: Container(
                  width: 40,
                  height: 50,
                  child: InkWell(
                    child: Image.asset('assets/images/icon6.png'),
                    onTap: () {
                      setState(() {
                        vegan = 6;
                        sliderWidth = 50 * vegan + 7.5;
                        setSlider(6);
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 5,
                bottom: 5,
                left: 310,
                child: Container(
                  width: 40,
                  height: 50,
                  child: InkWell(
                    child: Image.asset('assets/images/icon7.png'),
                    onTap: () {
                      setState(() {
                        vegan = 7;
                        sliderWidth = 50 * vegan + 7.5;
                        setSlider(7);
                      });
                    },
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Text("수정"),
              onPressed: () {
                profileUpadte(new_vegan: vegan);
              },
            ),
          )
        ],
      ),
    );
  }
}
