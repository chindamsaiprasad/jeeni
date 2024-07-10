import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  const TestInstructions({
    required this.test,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TestInstructionsState();
}

class _TestInstructionsState extends ConsumerState<TestInstructions> {
  bool isStartEnable = false;

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
    ref.read(timerProvider).updateDuration(widget.test.durationInMinutes ?? 0);
  });
    super.initState();
  }

  // setTimerprovier() async{
  //   ref.read(timerProvider).updateDuration(widget.test.durationInMinutes ?? 0);
  // }

  @override
  Widget build(BuildContext context) {

    final timerService = ref.watch(timerProvider);
    int hours = timerService.duration.inHours;
    int minutes = timerService.duration.inMinutes.remainder(60);
    int seconds = timerService.duration.inSeconds.remainder(60);

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
              CustomRichText(
                number: "2",
                firstText: "The total duration of exam is ",
                secondText: widget.test.durationInMinutes?.toString() ?? "",
                thirdText: " Minutes.",
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
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 5,right: 5),
                child: Table(
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
                    alignment: Alignment.centerLeft,
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
                          TableRow(
                            children: [
                TableCell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      "  Physics",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      " ${widget.test.numberOfQuestions ?? 0}",
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
                      ),
              ),
              const Spacer(),
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
                      // StopWatch(
                      //   duration: (_duration?.inSeconds ?? 0) > 0
                      //       ? _duration ?? const Duration(seconds: 00)
                      //       : const Duration(seconds: 00),
                      //   callback: () {
                      //     setState(() {
                      //       isStartEnable = true;
                      //     });
                      //   },
                      // )
                      Text('${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 26),),
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
                  onPressed: () {
                    timerService.startTimer();
                    Navigator.pop(context, true);
                  },
                  // onPressed: isStartEnable
                  //     ? () {
                  //         Navigator.pop(context, true);
                  //       }
                  //     : null,
                  // onPressed: () {
                  //   timerService.startTimer();
                  //   // timerService.stopTimer();
                  // },
                  child: const Text("Start Test", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
