import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/response_models/submit_test_response.dart';

class ResultPage extends ConsumerWidget {
  final SubmitTestResponse submitTestResponse;
  const ResultPage({
    required this.submitTestResponse,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text(
          "Result Summary",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Material(
                  elevation: 10,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        _buildResultCell("Test Name", "Practice Test", context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        _buildResultCell("Test Date", "", context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        _buildResultCell("Duration", "", context),
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
                            submitTestResponse.attemptedQuestions?.toString() ??
                                "",
                            context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
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
                            submitTestResponse.inCorrectAnswer?.toString() ??
                                "",
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
                        _buildResultCell(
                            "Bonus",
                            submitTestResponse.bonus?.toString() ?? "",
                            context),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xff1c5e20)),
                ),
                onPressed: () {},
                child: const Text("View Answer"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildResultCell(String title, String value, BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
