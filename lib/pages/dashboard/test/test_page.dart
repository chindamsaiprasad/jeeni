import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/enums/answer_status.dart';
import 'package:jeeni/enums/question_type.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/dashboard/test/hiden_header.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/basic_question.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/comprehension_question.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/integer_question.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/matrix_question.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/multiple_question.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/numeric_question.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/providers/test_time._provider.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestPage extends ConsumerStatefulWidget {
  final TestResponse testDownloadResponse;
  final bool diffrentBool;
  const TestPage({
    required this.testDownloadResponse,
    this.diffrentBool = false,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {
  final ItemScrollController questionNumberScrollController =
      ItemScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1),
      () {
        ref.read(testProgressProvider).init(widget.testDownloadResponse);
      },
    );

    //    WidgetsBinding.instance.addPostFrameCallback((_) {
    //   checkAndSubmitTest();
    // });
  }

  void checkAndSubmitTest() {
    final timerService = ref.read(timerProvider);
    if (timerService.duration == Duration.zero) {
      OverlayLoader.show(context: context, title: "Submitting");
      print("this wroks");
      ref.read(testProgressProvider).submitTest().then((response) {
        print("3333333333333333333333333 VALUE");
        if (response != null) {
          print("3333333333333333333333333 if VALUE");
          timerService.stopTimer();
          Navigator.pop(context, response);
        }
      }).catchError((onError) {
        // Handle error
      }).whenComplete(() => OverlayLoader.hide());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildAppBar(),
            // _buildCollapsebleContainer(),
            const HidenHeader(),
            _buildQuestionNumberList(),
            _buildQuestionContainer(),
            _buildFooterButtons()
          ],
        ),
      ),
    );
  }

  Container _buildAppBar() {
    final timerService = ref.watch(timerProvider);
    int hours = timerService.duration.inHours;
    int minutes = timerService.duration.inMinutes.remainder(60);
    int seconds = timerService.duration.inSeconds.remainder(60);

    if (timerService.duration == Duration.zero) {
      print("ok time over");
      // Trigger test submission check every time the duration changes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkAndSubmitTest();
      });
    } else {
      // print("Time is not over");
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      width: double.infinity,
      color: AppColour.darkGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Mock Test",
            style: TextStyle(color: AppColour.white),
          ),
          Text(
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          // Text(
          //   ref
          //       .watch(testProgressProvider)
          //       .getremaingDurationInSeconds
          //       .toString(),
          //   style: const TextStyle(color: AppColour.white),
          // ),
          SizedBox(
            width: 125,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                if (widget.diffrentBool) {
                  print("heellow");
            
                } else {
                  OverlayLoader.show(context: context, title: "Submiting");
                  print("444444444444444444444444 VALUE");
                  ref
                      .read(testProgressProvider)
                      .submitTest()
                      .then((response) {
                        print("3333333333333333333333333 VALUE");
                        if (response != null) {
                          print("3333333333333333333333333  if VALUE");
            
                          timerService.stopTimer();
            
                          print("responsetest page $response");
                          Navigator.pop(context, response);
                        }
                      })
                      .catchError((onError) {})
                      .whenComplete(() => OverlayLoader.hide());
                }
              },
              child: const Text(
                "Submit Test",
                style: TextStyle(color: AppColour.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool hasHide = true;
  _buildCollapsebleContainer() {
    final currentQuestion = ref.watch(testProgressProvider).getCurrentQuestion;
    return Column(
      children: [
        hasHide
            ? Container(
                height: 90,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // color: Colors.red,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(currentQuestion?.section ?? ""),
                          Text(currentQuestion?.questionType ?? ""),
                          currentQuestion?.isMultipleAnswer ?? false
                              ? const Text("Multiple Answer")
                              : const Text("Single Answer"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _buildCorrectIncorrect(
                                "Correct",
                                "+${currentQuestion?.positiveMark?.toInt()}",
                                Colors.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              _buildCorrectIncorrect(
                                "Incorrect",
                                "-${currentQuestion?.negativeMark?.toInt()}",
                                Colors.red,
                              ),
                            ],
                          ),
                          Text(
                            "${ref.read(testProgressProvider).currentQuestionIndex() + 1} of ${ref.read(testProgressProvider).getQuestionCount}",
                            style: const TextStyle(color: Colors.amber),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Container(),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
            ),
            onPressed: () {
              setState(() {
                hasHide = !hasHide;
              });
            },
            icon: Icon(
              hasHide ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down,
              color: AppColour.green,
            ),
            label: const Text(
              "Hide",
              style: TextStyle(color: AppColour.green),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildCorrectIncorrect(String title, String marks, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: color),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(
          '$title $marks',
          style: TextStyle(color: color, fontSize: 12),
        ),
      ),
    );
  }

  Material _buildQuestionNumberList() {
    final questions = ref.watch(testProgressProvider).getQuestion;

    return Material(
      elevation: 5,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 60,
        width: double.infinity,
        child: ScrollablePositionedList.builder(
          itemScrollController: questionNumberScrollController,
          itemCount: questions.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final question = questions[index];
            if (question.questionType == "Integer") {
              // print("_buildQuestionNumberList ${question.customAnswerStatus}");
            }

            return InkWell(
              onTap: () {
                // print("question id ${index} ${question.id}");
                ref
                    .read(testProgressProvider)
                    .updateCurrentQuestion(question.id ?? 0);
              },
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: ref
                                  .read(testProgressProvider)
                                  .getCurrentQuestion
                                  ?.id ==
                              question.id
                          ? Border.all(
                              width: 3,
                              color: const Color.fromARGB(255, 4, 109, 122),
                            )
                          : Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: question.customAnswerStatus.backgroundColur,
                    ),
                    child: Text(
                      'Q${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  question.customAnswerStatus ==
                          AnswerStatus.ANSWERED_AND_MARK_FOR_REVIEW
                      ? Positioned(
                          top: 8,
                          right: 10,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            height: 9,
                            width: 9,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: TestPageColour.answeredColor,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Expanded _buildQuestionContainer() {
    final testProvider = ref.watch(testProgressProvider);

    return Expanded(
      child: !testProvider.isLoading && testProvider.getCurrentQuestion != null
          ? getQuestionWidgetByType(testProvider.getCurrentQuestion!)
          : Container(),
    );
  }

  Widget getQuestionWidgetByType(QuestionMobileVos question) {
    print("QUESTION ::${question.questionType}");
    switch (question.questionType) {
      case QuestionType.BASIC ||
            QuestionType.COMPREHENSION ||
            QuestionType.ASSERTION_AND_REASON ||
            QuestionType.COLUMN_MATCHING:
        if (question.isMultipleAnswer ?? false) {
          return MultipleQuestion(question: question);
        }
        return BasicQuestion(question: question);
      case QuestionType.INTEGER:
        return IntegerQuestion(question: question);
      case QuestionType.MATRIX:
        return MatrixQuestion(question: question);
      case QuestionType.NUMERIC:
        return NumericQuestion(question: question);
      default:
        if (question.questionType?.contains("ASSERTION") ?? false) {
          return BasicQuestion(question: question);
        }
        return const Text("DATA NOT MATCH");
    }
  }

  Container _buildFooterButtons() {
    return Container(
      height: 60,
      color: Colors.white,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              ref.read(testProgressProvider).previous();
              jumpToSelectedIndex();
            },
            child: const Text(
              "Prev",
              style: TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            height: 40,
            color: Colors.grey,
            width: 0.5,
          ),
          TextButton(
            onPressed: () {
              ref.read(testProgressProvider).markForReview();
            },
            child: Text(
              "Mark Review & Next",
              style: TextStyle(
                color: Colors.purple[200],
                fontSize: 14,
              ),
            ),
          ),
          Container(
            height: 40,
            color: Colors.grey,
            width: 0.5,
          ),
          TextButton(
            onPressed: () {
              ref.read(testProgressProvider).next();
              jumpToSelectedIndex();
            },
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  jumpToSelectedIndex() {
    final index = ref.read(testProgressProvider).currentQuestionIndex();
    if (index != -1) {
      scrollTo(index);
    }
  }

  void scrollTo(int index) => questionNumberScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
        alignment: 0,
      );
}
