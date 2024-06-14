import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/test/result_page.dart';
import 'package:jeeni/pages/dashboard/test/test_instructions.dart';
import 'package:jeeni/pages/dashboard/test/test_page.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/pages/solution/view_questions_solution.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/response_models/submit_test_response.dart';
import 'package:jeeni/utils/date_formator.dart';

class TestListPage extends ConsumerStatefulWidget {
  const TestListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestListPageState();
}

class _TestListPageState extends ConsumerState<TestListPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final tests = ref.watch(testProvider).tests;

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text("Test",style: TextStyle(color: Colors.white,fontSize: 22),),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mock Test"),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: tests.isEmpty
                  ? const Center(
                      child: Text("Test are comming soon..."),
                    )
                  : ListView(
                      children: tests
                          .map(
                            (test) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(test.name ?? ""),
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xff1c5e20)),
                                          ),
                                          onPressed: () {
                                            final deviceWidth =
                                                MediaQuery.of(context)
                                                    .size
                                                    .width;
                                            final deviceHeight =
                                                MediaQuery.of(context)
                                                    .size
                                                    .height;

                                            OverlayLoader.show(
                                                context: context);
                                            final testId = test.id!;
                                            ref
                                                .read(testProvider)
                                                .pretestDownload(
                                                    testId: testId,
                                                    deviceWidth: deviceWidth,
                                                    deviceHeight: deviceHeight)
                                                .then((response) {

                                                  print("first step ${response.toString()}");
                                                  
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TestInstructions(
                                                    test:
                                                        test,
                                                  ),
                                                ),
                                              ).then((toStart) {
                                                if (toStart) {
                                                  print("second steep $response");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TestPage(
                                                        testDownloadResponse:
                                                            response,
                                                      ),
                                                    ),
                                                  ).then((value) {
                                                    print(
                                                        "111111111111111111111111111");
                                                        print("third steep $value");

                                                    if (value
                                                        is SubmitTestResponse) {
                                                      print(
                                                          "22222222222222222222222222222  if");
                                                          print("fourth step $value");
                                                      Navigator.push<
                                                          SubmitTestResponse>(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ResultPage(
                                                                  submitTestResponse:
                                                                      value),
                                                        ),
                                                      ).then(
                                                          (submitTestResponse) {
                                                        print(
                                                            "11111111111111111111111111 result");
                                                        if (submitTestResponse !=
                                                            null) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return ViewQuestionSolution(
                                                                solutionProvider:
                                                                    ChangeNotifierProvider(
                                                                  (ref) =>
                                                                      SolutionProvider(
                                                                    submitTestResponse:
                                                                        submitTestResponse,
                                                                    ref: ref,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ));
                                                        }
                                                      });
                                                    }
                                                  });
                                                }
                                              }).then((value) {});
                                              OverlayLoader.hide();
                                            }).catchError((error) {
                                              //TODO :: HANDLE ERROR
                                            });
                                          },
                                          child: const Text("Download", style: TextStyle(color: Colors.white),),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                            children: [
                                              const TextSpan(text: "Start : "),
                                              TextSpan(
                                                text:
                                                    "${DateFormator.getFormatedDate(test.startTime ?? 0)}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black26,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${test.numberOfQuestions} Questions (${test.durationInMinutes} min)",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
