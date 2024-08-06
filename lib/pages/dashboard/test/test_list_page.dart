import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jeeni/enums/question_type.dart';
import 'package:jeeni/pages/dashboard/test/result_page.dart';
import 'package:jeeni/pages/dashboard/test/test_instructions.dart';
import 'package:jeeni/pages/dashboard/test/test_page.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/pages/solution/view_questions_solution.dart';
import 'package:jeeni/providers/network_error_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/response_models/submit_test_response.dart';
import 'package:jeeni/response_models/test_response.dart';
import 'package:jeeni/utils/date_formator.dart';
import 'package:jeeni/utils/result_util.dart';

class TestListPage extends ConsumerStatefulWidget {
  const TestListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestListPageState();
}

class _TestListPageState extends ConsumerState<TestListPage> {
  bool isLoading = false;

  bool searchenable = false;
  TextEditingController searchTextController = TextEditingController();

  Iterable<Test> tests = [];
  Iterable<Test> filtertests = [];

  String convertTime(int? ipocTime) {
    // Check if the input is null
    if (ipocTime == null) {
      return '';
    }

    int epochTime = (ipocTime / 1000).round();
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: true);
    var desiredTimezone = 'Asia/Kolkata';
    dateTime = dateTime.toUtc().add(const Duration(hours: 5, minutes: 30));
    var formatter = DateFormat('dd/MM/yyyy, hh:mm a');
    String convertedTime = formatter.format(dateTime);
    return convertedTime;
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  getrefreshData() {
    OverlayLoader.show(context: context, title: "Loading...");
    ref.read(testProvider).fetchAllTestsFromJeeniServer().then((response) {
      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        ref.read(networkErrorProvider).resolveError();
      }
    }).catchError((error) {
      // TODO: Implement error handling logic
      print('Error: $error');
    }).whenComplete(() {
      OverlayLoader.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tests = ref.watch(testProvider).tests;

    final String searchText = searchTextController.text;

    final filteredResultData = tests.where((data) {
      return data.name!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text(
          "Test",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 18,
            ),
            onPressed: () {
              // Add your onPressed code here!
              setState(() {
                searchenable = !searchenable;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.arrowsRotate,
              size: 18,
            ),
            onPressed: () {
              // Add your onPressed code here!
              getrefreshData();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Padding(
          //   padding: EdgeInsets.only(left: 10),
          //   child: Text(
          //     "Mock Test",
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //   ),
          // ),
          searchenable
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 12, right: 12, left: 12, bottom: 0),
                  child: TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Search Test...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                    // onChanged: filterResults,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: filteredResultData.isEmpty
                ? const Center(
                    child: Text(
                      "No tests found",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView(
                    children: filteredResultData
                        .map(
                          (test) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            test.name ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              //   fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xff1c5e20)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
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
                                              // print(
                                              // "first step ${response.toString()}");
                                              final questions =
                                                  response.questionMobileVos ??
                                                      [];
                                              for (var question in questions) {
                                                print("===============");
                                                print(question.toString());
                                              }

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TestInstructions(
                                                    test: test,
                                                  ),
                                                ),
                                              ).then((toStart) {
                                                if (toStart) {
                                                  print(
                                                      "second steep $response");
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
                                                      print(
                                                          "fourth step $value");
                                                      Navigator.push<
                                                          SubmitTestResponse>(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ResultPage(
                                                            submitTestResponse:
                                                                value,
                                                            test: test,
                                                          ),
                                                        ),
                                                      ).then(
                                                          (submitTestResponse) {
                                                        print(
                                                            "11111111111111111111111111 result  $submitTestResponse");
                                                        if (submitTestResponse !=
                                                            null) {
                                                          final result =
                                                              ResultUtil()
                                                                  .convertToResult(
                                                            submitTestResponse,
                                                          );
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return ViewQuestionSolution(
                                                                  solutionProvider:
                                                                      ChangeNotifierProvider(
                                                                    (ref) => SolutionProvider(
                                                                        currentQuestion:
                                                                            result
                                                                                .first,
                                                                        solution:
                                                                            result,
                                                                        ref:
                                                                            ref),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        }
                                                      });
                                                    }
                                                  });
                                                }
                                              }).then((value) {});
                                              OverlayLoader.hide();
                                            }).catchError((error) {
                                              OverlayLoader.hide();
                                            });
                                          },
                                          child: const Text(
                                            "Attempt",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
                                              const TextSpan(
                                                  text: "Start : ",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 13)),
                                              TextSpan(
                                                text: convertTime(test.endTime),
                                                // convertTime(test.examDate),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
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
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
