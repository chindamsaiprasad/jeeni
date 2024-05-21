import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/test/test_instructions.dart';
import 'package:jeeni/pages/dashboard/test/test_page.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/test_provider.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text("Test"),
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
              child: ListView(
                children: ref
                    .read(testProvider)
                    .tests
                    .map(
                      (test) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(test.name ?? ""),
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xff1c5e20)),
                                    ),
                                    onPressed: () {
                                      final deviceWidth =
                                          MediaQuery.of(context).size.width;
                                      final deviceHeight =
                                          MediaQuery.of(context).size.height;

                                      OverlayLoader.show(context: context);
                                      final testId = test.id!;
                                      ref
                                          .read(testProvider)
                                          .pretestDownload(
                                              testId: testId,
                                              deviceWidth: deviceWidth,
                                              deviceHeight: deviceHeight)
                                          .then((response) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TestInstructions(
                                              testDownloadResponse: response,
                                            ),
                                          ),
                                        ).then((toStart) {
                                          if (toStart) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => TestPage(
                                                  testDownloadResponse:
                                                      response,
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                        OverlayLoader.hide();
                                      }).catchError((error) {
                                        //TODO :: HANDLE ERROR
                                      });
                                    },
                                    child: const Text("Download"),
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
                                              "${DateFormator.getFormatedDate(test.examDate ?? 0)}",
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
