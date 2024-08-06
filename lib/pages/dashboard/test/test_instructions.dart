import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/widgets/rich_text.dart';
import 'package:jeeni/pages/widgets/stop_watch.dart';
import 'package:jeeni/providers/test_time._provider.dart';
import 'package:jeeni/response_models/test_response.dart';
import 'package:jeeni/utils/app_colour.dart';

class TestInstructions extends ConsumerStatefulWidget {
  final Test test;
  final TestDownloadResponse downloadTestResult;
  const TestInstructions({
    required this.test,
    required this.downloadTestResult,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TestInstructionsState();
}

class _TestInstructionsState extends ConsumerState<TestInstructions> {
  bool isStartEnable = false;

  TextEditingController testPasswordController = TextEditingController();

  Duration? _duration;

  @override
  void initState() {
    print("Start Time ${widget.test.startTime}");
    DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(widget.test.startTime ?? 0);
    _duration = startTime.difference(DateTime.now());

    // ref.read(timerProvider).updateDuration(widget.test.durationInMinutes ?? 0);
    // setTimerprovier();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref
          .read(timerProvider)
          .updateDuration(widget.test.durationInMinutes ?? 0);
    });
    super.initState();
  }

  // setTimerprovier() async{
  //   ref.read(timerProvider).updateDuration(widget.test.durationInMinutes ?? 0);
  // }

  @override
  Widget build(BuildContext context) {
    // final timerService = ref.watch(timerProvider);
    // int hours = timerService.duration.inHours;
    // int minutes = timerService.duration.inMinutes.remainder(60);
    // int seconds = timerService.duration.inSeconds.remainder(60);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.delayed(
          const Duration(),
          () {
            return true;
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text(
            "Test Instructions",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRichText(
                number: "1",
                firstText: "Exam name is ",
                secondText: widget.test.name ?? "",
                thirdText: ".",
                color: AppColour.darkGreen,
              ),
              // CustomRichText(
              //   number: "2",
              //   firstText: "The total duration of exam is ",
              //   secondText: widget.test.durationInMinutes?.toString() ?? "",
              //   thirdText: " Minutes.",
              //   color: Colors.red,
              // ),
              CustomRichText(
  number: "2",
  firstText: widget.test.durationInMinutes == 0 
    ? "The exam has no time limit." 
    : "The total duration of exam is ",
  secondText: widget.test.durationInMinutes != 0 
    ? widget.test.durationInMinutes?.toString() ?? "" 
    : "",
  thirdText: widget.test.durationInMinutes != 0 
    ? " Minutes."
    : "",
  color: Colors.red,
),
              CustomRichText(
                number: "3",
                firstText: "The exam is contains ",
                secondText: " ${widget.test.numberOfQuestions ?? 0} ",
                thirdText: " questions.",
                color: Colors.red,
              ),
              const CustomRichText(
                number: "4",
                firstText:
                    "Four possible answers are given and there is one or more correct answer for each question.",
                secondText: "",
                thirdText: "",
                color: Colors.red,
              ),
              const CustomRichText(
                number: "5",
                firstText:
                    "Do not log-in on any other device during the examination.",
                secondText: "",
                thirdText: "",
                color: Colors.red,
              ),
              const CustomRichText(
  number: "5",
  firstText: "Unusual activity can lead to automatic exam submission.",
  secondText: "",
  thirdText: "",
  color: Colors.red,
),
              SizedBox(
                height: 10,
              ),
              getSubjectListTable(widget.downloadTestResult),

              // const Spacer(),
              SizedBox(
                height: 60,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text(
                        "You can start your test now!",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColour.darkGreen,
                        ),
                      ),
                      StopWatch(
                        duration: (_duration?.inSeconds ?? 0) > 0
                            ? _duration ?? const Duration(seconds: 00)
                            : const Duration(seconds: 00),
                        callback: () {
                          setState(() {
                            isStartEnable = true;
                          });
                        },
                      )
                      // Text('${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                      // style: const TextStyle(fontSize: 26),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  // onPressed: () {
                  //   timerService.startTimer();
                  //   Navigator.pop(context, true);
                  // },
                  onPressed: isStartEnable
                      ? () {
                          // Navigator.pop(context, true);
                          if (widget.test.password!.isNotEmpty) {
                            // print("test pass not epmty  ${widget.test.password}");
                            _showPasswordPopup(context);
                          } else {
                            print("empty pass ${widget.test.password}");
                            Navigator.pop(context, true);
                          }
                        }
                      : null,
                  // onPressed: () {
                  //   timerService.startTimer();
                  //   // timerService.stopTimer();
                  // },
                  child: const Text(
                    "Start Test",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget getSubjectListTable(TestDownloadResponse test) {
  List<QuestionMobileVos>? questionMobileVos = test.questionMobileVos;

  // Create a map to store the frequency of each section
  Map<String, int> sectionFrequency = {};

  if (questionMobileVos != null) {
    // Iterate through the list and update the frequency map
    for (var question in questionMobileVos) {
      String section = question.section as String;
      if (sectionFrequency.containsKey(section)) {
        sectionFrequency[section] = sectionFrequency[section]! + 1;
      } else {
        sectionFrequency[section] = 1;
      }
    }

    // Create a list of MapEntry from sectionFrequency for the ListView.builder
    List<MapEntry<String, int>> sectionList = sectionFrequency.entries.toList();

    // print("section list ${sectionList}");

    // // Define additional entries
    // List<MapEntry<String, int>> additionalEntries = [
    //   MapEntry("Additional Subject 1", 10),
    //   MapEntry("Additional Subject 2", 20),
    // ];

    // // Add the additional entries to the sectionList
    // sectionList.addAll(additionalEntries);

    return Flexible(
      // height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Static Table Header
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[400]),
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: const Text(
                          "  Subject",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: const Text(
                          "  Total Questions",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Dynamic Rows from ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: sectionList.length,
                itemBuilder: (context, index) {
                  final entry = sectionList[index];
                  return Table(
                    border: TableBorder.all(color: Colors.grey),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "  ${entry.key}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: Text(
                                "${entry.value}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text('The list of questionMobileVos is null.'),
      ),
    );
  }
}

  void _showPasswordPopup(BuildContext context,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _isPasswordVisible = true;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  shape: BoxShape
                      .rectangle, // Explicitly setting the shape to rectangle
                  borderRadius:
                      BorderRadius.circular(0), // Adding rounded corners
                ),
                // color: Colors.green,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      color: const Color(0xff1c5e20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Test Name : ${widget.test.name}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                testPasswordController.clear();
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 130,
                      width: 400,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: testPasswordController,
                                  obscureText: _isPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Test Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "Enter Password",
                                    border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        print("$_isPasswordVisible");
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Navigator.of(context).pop(); // Close the dialog
                                    if (widget.test.password ==
                                        testPasswordController.text) {
                                      // print("pass same ${widget.test.password} ${testPasswordController.text}");
                                      Navigator.of(context).pop();
                                      Navigator.pop(context, true);
                                    } else {
                                      // print("not same pass");
                                      EasyLoading.showError(
                                          "Please enter valid password");
                                    }
                                  },
                                  child: Text('Verify'),
                                ),
                                const SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle the password here
                                    // String password = _passwordController.text;
                                    // print('Password: $password'); // Print the password for demonstration
                                    testPasswordController.clear();
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
