import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHome(),
  ));
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late int numberOfSub;
  int totalSubs = 0;
  double average = 0;
  int highestPerSub = 0;
  int marks = 0;
  int numSub = 3;
  int count = 0;
  int totalLength = 0;
  // bool isNumOfSubFieldEnabled = false;
  // bool isMarksFiedEnbled = false;
  int counter = 1;
  bool isReadOnly = false;
  bool isFirstClick = false;
  bool isVisible = false;
  List<int> subs = [];

  // _MyHomeState() {
  // subs = [];
  // if (int.tryParse(numOfSubController.text) != null) {
  //   numberOfSub = int.parse(numOfSubController.text);
  //   subs = List<int>.filled(1, int.parse(subController.text));
  // }
  // if (double.tryParse(subController.text) != null) {
  //   marks = int.parse(subController.text);
  // }
  //   totalLength = int.parse(numOfSubController.text);
  // }

  //? -> Controllers
  final numOfSubController = TextEditingController();
  final subController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Subjects Calculator",
            ),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: TextField(
                    controller: numOfSubController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none),
                        hintText: "Enter number of subjects",
                        hintStyle: TextStyle(fontSize: 18.0),
                        filled: true,
                        fillColor: Colors.blueGrey[50])),
              ),
              SizedBox(
                height: 2.0,
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: subs.length == totalLength
                        ? const Text(
                            "Enter subject ",
                            style: TextStyle(fontSize: 16.0),
                          )
                        : Text(
                            "Enter subject $counter",
                            style: TextStyle(fontSize: 16.0),
                          )),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                child: Visibility(
                  visible: isVisible,
                  child: TextField(
                      controller: subController,
                      keyboardType: TextInputType.number,
                      readOnly: false,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          hintText: "Enter Marks",
                          hintStyle: TextStyle(fontSize: 18.0),
                          filled: true,
                          fillColor: Colors.blueGrey[50])),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                padding: EdgeInsets.only(right: 10, left: 10),
                child: ElevatedButton(
                    onPressed: () {
                      totalLength = int.parse(numOfSubController.text);
                      if (numOfSubController.text.isEmpty) {
                        print("Error Num Of Sub Field is empty!!");
                      } else {
                        setState(() {
                          isVisible = true;
                        });
                        if (subController.text.isEmpty) {
                          print("Error the marks field is empty!!!");
                        } else {
                          setState(() {
                            int mrks = int.parse(subController.text);
                            subs.add(mrks);
                            subController.clear();
                            counter++;
                            print("The Visbility is: $isVisible");
                          });
                        }
                        if (subs.length == totalLength) {
                          //?-> For Debuging purpose`
                          counter = 0;
                          numOfSubController.clear;
                          print("All values are entered: $subs");
                          print("The total length is: $totalLength");
                          calculateMarks(subs);
                          print("Total : $totalSubs \nAverage: $average \nHighestPerSubject: $highestPerSub");
                        }}
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 15.0,
              ),
              subs.length >= totalLength
                  ? Visibility(
                    visible: isVisible,
                    child: Container(
                        color: Colors.grey[300],
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Total",
                              style: TextStyle(fontSize: 22.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "AVG",
                              style: TextStyle(fontSize: 22.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "HPS",
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ],
                        ),
                      ),
                  )
                  : Container(),
              SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        totalSubs.toString(),
                        style: TextStyle(fontSize: 22.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        average.toString(),
                        style: TextStyle(fontSize: 22.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        highestPerSub.toString(),
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }

  void isSubsFiedl(TextEditingController controller) {
    String conString = controller.text.toString();
    if (conString.isEmpty) {
      isReadOnly = true;
    } else {
      isReadOnly = false;
    }
  }

  void calculateMarks(List<int> subjects) {
    int highestSub = 0;
    for (var mrks in subjects) {
      totalSubs += mrks;
    }
    double avg = totalSubs / totalLength;
    double rounded = (avg * 100).round() / 100;
    average = rounded;

    highestSub = subjects[0];
    for (int i = 0; i < subjects.length; i++) {
      if (highestSub < subjects[i]) {
        highestSub = subjects[i];
      }
      highestPerSub = highestSub;
    }
  }
}
