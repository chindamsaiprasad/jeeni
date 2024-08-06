import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jeeni/pages/solution/view_questions_solution.dart';
import 'package:jeeni/response_models/submit_test_response.dart';
import 'package:jeeni/response_models/test_response.dart';
import 'package:jeeni/utils/constants.dart';
import 'package:jeeni/utils/date_formator.dart';

class ResultPage extends ConsumerWidget {
  final SubmitTestResponse submitTestResponse;
  final Test? test;
  final VoidCallback? onBack;

// Default constructor
  const ResultPage({
    super.key,
    required this.submitTestResponse,
    required this.onBack,
    this.test,
  });

  // // Named constructor that initializes with only SubmitTestResponse
  // ResultPage.withSubmitTestResponse({super.key,
  //   required this.submitTestResponse,
  // }) : test = Test.defaultTest();

  String convertEpochToCustomTimeZone(int? ipocTime) {
    // Check if the input is null
    if (ipocTime == null) {
      return '';
    }

    int epochTime = (ipocTime / 1000).round();
    // Create a DateTime object from the epoch time
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: true);

    var desiredTimezone = 'Asia/Kolkata';
    dateTime = dateTime.toUtc().add(const Duration(hours: 5, minutes: 30));

    var formatter = DateFormat('dd/MM/yyyy').addPattern(' z');
    String convertedTime = formatter.format(dateTime);

    return convertedTime;
  }

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
          onPopInvoked: (bool didPop) async {

              if (didPop) {
                return;
              }
            
            print("didpop $didPop");
            onBack!();
            Navigator.pop(context);
            // Navigator.pop(context, true);
          },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text(
            "Result Summary",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            onBack!(); 
            Navigator.pop(context);
          },
        ),
          iconTheme: const IconThemeData(
              color: Colors.white,
            ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        _buildResultCell("Test Name", "${test?.name}", context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        _buildResultCell(
                            "Test Date",
                            convertEpochToCustomTimeZone(test!.examDate),
                            context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        _buildResultCell("Duration",
                            "${test?.durationInMinutes} Minutes", context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        _buildResultCell(
                            "Total Questions",
                            submitTestResponse.totalQuestions?.toString() ?? "",
                            context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        _buildResultCell(
                            "Attempted Questions",
                            ((submitTestResponse.totalQuestions ?? 0) -
                                    (submitTestResponse.unAttemptedQuestions ??
                                        0))
                                .toString(),
                            context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
      
                        (test?.resultVerificationFlag ?? true) 
        ? Container() 
        : hideImaidateResultColumn(context),
      
      
                       
                      ],
                    ),
                  ),
                ),
              ),
              hideViewSolutionButton(context),
            ],
          ),
        ),
      ),
    );
  }

  hideViewSolutionButton(context){
    return (test?.resultVerificationFlag ?? true)
      ? SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            onPressed: null,
            child: const Text(
              "Result is not available.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      : SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context, submitTestResponse);
            },
            child: const Text(
              "View Answer",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
  }

  hideImaidateResultColumn(context){
    return Column(
      children: [
         _buildResultCell(
                          "Correct Answers",
                          submitTestResponse.correctAnswers?.toString() ?? "",
                          context),
                      const Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                      _buildResultCell(
                          "Incorrect Answers",
                          submitTestResponse.inCorrectAnswer?.toString() ?? "",
                          context),
                      const Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                      _buildResultCell(
                          "Partial Answers",
                          submitTestResponse.partialCorrect?.toString() ?? "",
                          context),
                      const Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                      _buildResultCell(
                          "Marks Obtained",
                          "${submitTestResponse.score} Out Of ${submitTestResponse.outOfScore}",
                          context),
                      const Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                      _buildResultCell("Bonus",
                          submitTestResponse.bonus?.toString() ?? "", context),
                      const Divider(
                        color: Colors.black,
                        height: 1,
                      ),
      ],
    );
  }

  _buildResultCell(String title, String value, BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 5,
              child: Row(
                children: [
                  Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
