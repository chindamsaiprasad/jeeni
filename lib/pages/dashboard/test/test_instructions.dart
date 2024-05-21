import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/widgets/rich_text.dart';
import 'package:jeeni/utils/app_colour.dart';

class TestInstructions extends ConsumerStatefulWidget {
  final TestDownloadResponse testDownloadResponse;
  const TestInstructions({
    required this.testDownloadResponse,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TestInstructionsState();
}

class _TestInstructionsState extends ConsumerState<TestInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text(
          "Test Instructions",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomRichText(
              number: "1",
              firstText: "Exam name is ",
              secondText: "Parabola",
              thirdText: ".",
              color: AppColour.darkGreen,
            ),
            const CustomRichText(
              number: "2",
              firstText: "The total duration of exam is ",
              secondText: "40 ",
              thirdText: "Minutes.",
              color: Colors.red,
            ),
            const CustomRichText(
              number: "3",
              firstText: "The exam is contains ",
              secondText: "40 ",
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
            Material(
              elevation: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: double.infinity,
                            color: Colors.grey[400],
                            child: const Text(
                              "  Subject",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: double.infinity,
                            color: Colors.grey[400],
                            child: const Text(
                              "  Total Questions",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: double.infinity,
                            child: Text(
                              "  Physics",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: double.infinity,
                            child: Text(
                              "  35",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Material(
              elevation: 4,
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "You can start your test now!",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColour.darkGreen,
                      ),
                    ),
                    Text(
                      "00:00",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.red,
                      ),
                    ),
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
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColour.darkGreen),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Start Test"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
