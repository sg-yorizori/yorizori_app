import 'package:flutter/material.dart';
import 'package:yorizori_app/User/models/user.dart';

class Disliked extends StatefulWidget {
  List<String> user_disliked;
  Disliked({Key? key, required this.user_disliked}) : super(key: key);

  @override
  _DislikedState createState() => _DislikedState();
}

class _DislikedState extends State<Disliked> {
  final _dislikeController = TextEditingController();
  List<String> dislike_list = [];
  @override
  void initState() {
    dislike_list = widget.user_disliked;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.2,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "재료",
                      hintStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  controller: _dislikeController,
                ),
              ),
              SizedBox(width: width * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(0, 40),
                  //primary: Color(0xfffa4a0c),
                ),
                onPressed: () {
                  setState(() {
                    if (_dislikeController.text.isEmpty == true) return;

                    for (var i = 0; i < dislike_list.length; i++) {
                      if (dislike_list[i].compareTo(_dislikeController.text) ==
                          0) {
                        return;
                      }
                    }

                    dislike_list.add(_dislikeController.text);
                  });
                },
                child: Text(
                  '추가',
                  style: TextStyle(
                    color: Colors.white,
                    //fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            height: height * 0.07,
            child: FutureBuilder(
                future: _getinput(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView(
                    padding: EdgeInsets.only(left: 2, bottom: 5, top: 5),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: buildDislikes(dislike_list),
                  );
                }),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Text("수정"),
              onPressed: () {
                profileUpadte(new_disliked: dislike_list);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<List<String>> _getinput() async {
    return dislike_list;
  }

  List<Widget> buildDislikes(List<String> getDislikes) {
    //print(getRecipes.length);
    List<Widget> list = [];
    for (var i = 0; i < getDislikes.length; i++) {
      list.add(buildDislike(getDislikes[i], i));
      list.add(
        SizedBox(
          width: 10,
        ),
      );
    }
    return list;
  }

  Widget buildDislike(String dislike_one, int index) {
    return TextButton(
      style: TextButton.styleFrom(
          textStyle: TextStyle(fontWeight: FontWeight.w600),
          backgroundColor: Colors.white,
          primary: Colors.deepOrangeAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        setState(() {
          dislike_list.removeWhere((item) => item == dislike_one);
        });
      },
      child: Text(dislike_one),
      // child: const Text("Hi"),
    );
  }
}
