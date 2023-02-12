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
  bool isReadOnlySub = false;
  bool isFirstClick = false;
  bool isVisible = false;
  bool isVisibleTrue = false;
  List<int> subMarks = [];
  List<String> subNames = [];

  String? grade;

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
  final subNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if(totalLength > 0)
                  {
                    resetData();
                    isReadOnly = false;
                    isReadOnlySub = false;
                  }
                });
              },
              child: const Icon(Icons.restore),
            ),
          ),
        ],
        title: const Center(
          child: Text(
            "Subjects Calculator",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
           margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Image(image: AssetImage('images/male_user.png')),
                ),
                const SizedBox(height: 5,),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: TextField(
                      controller: numOfSubController,
                      readOnly: isReadOnlySub,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          hintText: "Enter number of subjects",
                          hintStyle: const TextStyle(fontSize: 18.0),
                          filled: true,
                          fillColor: Colors.blueGrey[50])),
                ),
                const SizedBox(height: 5.0,),
                Visibility(
                  visible: isVisible,
                  child: Container(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("Enter Subject $counter name",style: const TextStyle(fontSize: 16.0),)),
                ),
                  
                Visibility(
                  visible: isVisible,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: TextField(
                        controller: subNameController,
                        readOnly: isReadOnly,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          counterText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none),
                            hintText: "Enter subjects Name",
                            hintStyle: const TextStyle(fontSize: 18.0),
                            filled: true,
                            fillColor: Colors.blueGrey[50])),
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: subMarks.length == totalLength
                          ? const Text(
                              "Enter subject ",
                              style: TextStyle(fontSize: 16.0),
                            )
                          : Text(
                              "Enter subject $counter",
                              style: const TextStyle(fontSize: 16.0),
                            )),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  child: Visibility(
                    visible: isVisible,
                    child: TextField(
                        controller: subController,
                        keyboardType: TextInputType.number,
                        readOnly: isReadOnly,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        maxLength: 3,
                        decoration: InputDecoration(
                          counterText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none),
                            hintText: "Enter Marks",
                            hintStyle: const TextStyle(fontSize: 18.0),
                            filled: true,
                            fillColor: Colors.blueGrey[50])),
                  ),
                ),
                const SizedBox(
                  height: 0.0,
                ),
                Container(
                  height: 50.0,
                  width: double.infinity,
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        totalLength = int.parse(numOfSubController.text);
                        if (numOfSubController.text.isEmpty) {
                          print("Error Num Of Sub Field is empty!!");
                        } else {
                          setState(() {
                            int number = int.parse(numOfSubController.text);
                            if(number == 0)
                            {
                              print("0 and Negavite numbers is invalid");
                            }
                            else
                            {
                              isVisible = true;
                              isReadOnlySub = true;
                            }
                          });
                          if (subController.text.isEmpty) {
                            print("Error the marks field is empty or above desired input!!!");
                          } else {
                            if(int.parse(subController.text) > 100)
                            {
                              print("Invalid");
                            }
                            else
                            {
                              setState(() {
                              String subjects = subNameController.text; 
                              int mrks = int.parse(subController.text);
                              subMarks.add(mrks);
                              subController.clear();
                              counter++;
                              count++;
                              if(subNameController.text.isEmpty)
                              {
                                subNames.add("Subject $count"); 
                              }
                              else
                              {
                                subNames.add(subjects); 
                              }
                              subNameController.clear();
                            });
                            }
                          }
                          if (subMarks.length == totalLength) {
                            //?-> For Debuging purpose
                            //counter = 0;
                            numOfSubController.clear;
                            calculateMarks(subMarks);
                            print(subNames);
                            isVisibleTrue = true;
                            totalSubs = calcTotal(subMarks);
                            String avg = calAvg(totalSubs);
                            average = double.parse(avg);
                            String grd = gradingMarks(average);
                            grade = grd;
                            isReadOnly = true;
                          }
                        }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                const SizedBox(
                  height: 22.0,
                ),
                subNames.length == totalLength
                    ? Visibility(
                        visible: isVisibleTrue,
                        child: Container(
                            width: double.infinity,
                            margin:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: createTable(
                              rows: totalLength,
                              columnHeaders: ["Subject Name", "Marks", "Marking"],
                              rowHeaders: subNames,
                              data: subMarks,
                            )),
                      )
                    : Container(),
                const SizedBox(
                  height: 15.0,
                ),
                subMarks.length >= totalLength
                    ? Visibility(
                        visible: isVisible,
                        child: Container(
                          color: Colors.grey[300],
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
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
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Grade",
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 15.0,
                ),
                subMarks.length >= totalLength
                    ? Visibility(
                        visible: isVisible,
                        child: Container(
                          color: Colors.grey[300],
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                totalSubs.toString(),
                                style: const TextStyle(fontSize: 22.0),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                
                                average.toString(),
                                style: const TextStyle(fontSize: 22.0),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                highestPerSub.toString(),
                                style: const TextStyle(fontSize: 22.0),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                grade.toString(),
                                style: const TextStyle(fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ]),
        ),
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

//!-> The function is not in use
  void addSubs() {
    for (int i = 0; i < totalLength; i++) {
      subNames[i] = "Subject $counter";
    }
  }

  void calculateMarks(List<int> subjects) {
    int highestSub = 0;
    for (var mrks in subjects) {
      totalSubs += mrks;
    }

    highestSub = subjects[0];
    for (int i = 0; i < subjects.length; i++) {
      if (highestSub < subjects[i]) {
        highestSub = subjects[i];
      }
      highestPerSub = highestSub;
    }
  }

  //? -> Takes List of subjects and returns the total marks
  int calcTotal(List<int> subjects) {
    int total = 0;
    for (var mrks in subjects) {
      total += mrks;
      //totalSubs += mrks;
    }
    return total;
  }

  //? -> Takes the total and returns the average
  String calAvg(int total) {
    var avg = totalSubs / totalLength;
    String forAvg = avg.toStringAsFixed(2);
    return forAvg;
  }

  void resetData() {
    isVisible = false;
    isVisibleTrue = false;
    subController.clear();
    numOfSubController.clear();
    totalLength = 0;
    subMarks.clear();
    subNames.clear();
    counter = 0;
    count = 0;
    totalSubs = 0;
    average = 0;
    highestPerSub = 0;
    grade = "";
  }

  String gradingMarks(double avg) {
    String grade;
    if (avg >= 85 && avg <= 100) {
      grade = "A";
    } else if (avg >= 70 && avg <= 84) {
      grade = "B";
    } else if (avg >= 60 && avg <= 69) {
      grade = "C";
    } else if (avg >= 50 && avg <= 59) {
      grade = "D";
    }  else {
      grade = "F";
    }
    return grade;
  }

  Table createTable(
      {int rows = 1,
      List<String> columnHeaders = const [],
      List<String> rowHeaders = const [],
      List<int> data = const []}) {
    return Table(
      defaultColumnWidth: const FixedColumnWidth(100.0),
      children: List.generate(
        rows + 1,
        (rowIndex) => TableRow(
          children: List.generate(
            3,
            (colIndex) => Container(
              color: rowIndex == 0
                  ? Colors.grey[300]
                  : Colors.teal[100 * ((rowIndex - 1) % 2)],
              padding: const EdgeInsets.all(10.0),
              child: Text(
                rowIndex == 0
                    ? (colIndex < columnHeaders.length
                        ? columnHeaders[colIndex]
                        : '')
                    : (colIndex == 0
                        ? (rowIndex <= rowHeaders.length
                            ? rowHeaders[rowIndex - 1]
                            : '')
                        : (colIndex == 1 && rowIndex <= data.length
                            ? data[rowIndex - 1].toString()
                            : colIndex == 2
                                ? '100'
                                : '')),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight:
                        rowIndex == 0 ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
