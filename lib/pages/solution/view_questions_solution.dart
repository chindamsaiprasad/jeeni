import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/enums/answer_status.dart';
import 'package:jeeni/enums/question_type.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/solution/basic_solution.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewQuestionSolution extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<SolutionProvider> solutionProvider;

  const ViewQuestionSolution({
    super.key,
    required this.solutionProvider,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewQuestionSolutionState();
}

class _ViewQuestionSolutionState extends ConsumerState<ViewQuestionSolution> {
  @override
  Widget build(BuildContext context) {
    final currentQuestion = ref.watch(widget.solutionProvider).currentQuestion;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text(
            "Test Verification",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        ),
        body: Column(
          children: [
            _buildHeader(currentQuestion),
            _buildQuestionNumberList(),
            _buildQuestionContainer(currentQuestion, widget.solutionProvider),
            _buildFooterButtons()
          ],
        ),
      ),
    );
  }

  final ItemScrollController questionNumberScrollController =
      ItemScrollController();

  _buildHeader(Result? currentQuestion) {
    return Container(
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
                Row(
                  children: [
                    _buildCorrectIncorrect(
                      "+",
                      "${currentQuestion?.positiveMark ?? 0}",
                      Colors.green,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    _buildCorrectIncorrect(
                      "-",
                      "${currentQuestion?.negativeMark ?? 0}",
                      Colors.red,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${ref.read(widget.solutionProvider).currentQuestionIndex() + 1} of ${ref.read(widget.solutionProvider).getQuestionCount}",
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ],
                ),

                RichText(
                  text: TextSpan(
                    text: "Spent ",
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ': 0m 1s',
                          style: TextStyle(
                            color: Colors.red.shade400,
                          )),
                    ],
                  ),
                ),
                // _buildCorrectIncorrect(
                //   "Spent : 0m ",
                //   "${currentQuestion?.negativeMark ?? 0}",
                //   Colors.red,
                // ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(currentQuestion?.questionType ?? "Physic"),
                currentQuestion?.isMultipleAnswer ?? false
                    ? const Text("Multiple Answer")
                    : const Text("Single Answer"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Material _buildQuestionNumberList() {
    final questions = ref.watch(widget.solutionProvider).getQuestion;

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

            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: question.status.getColor(),
                    border: ref
                                .read(widget.solutionProvider)
                                .getCurrentQuestion
                                ?.questionId ==
                            question.questionId
                        ? Border.all(
                            width: 3,
                            color: const Color.fromARGB(255, 4, 109, 122),
                          )
                        : Border.all(
                            width: 1,
                            color: Colors.black38,
                          ),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Text(
                    'Q${index + 1}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                // question.customAnswerStatus ==
                //         AnswerStatus.ANSWERED_AND_MARK_FOR_REVIEW
                //     ? Positioned(
                //         top: 8,
                //         right: 10,
                //         child: Container(
                //           margin: const EdgeInsets.all(5),
                //           alignment: Alignment.center,
                //           height: 9,
                //           width: 9,
                //           decoration: const BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(25)),
                //             color: TestPageColour.answeredColor,
                //           ),
                //         ),
                //       )
                //     : Container(),
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded _buildQuestionContainer(
    Result? currentQuestion,
    ChangeNotifierProvider<SolutionProvider> solutionProvider,
  ) {
    if (currentQuestion == null) {
      return const Expanded(
        child: Text("Data not found"),
      );
    }
    if (currentQuestion.questionType == QuestionType.BASIC ||
        currentQuestion.questionType == QuestionType.COLUMN_MATCHING ||
        currentQuestion.questionType == QuestionType.COMPREHENSION) {
      return Expanded(
          child: BasicSolution(
              result: currentQuestion, solutionProvider: solutionProvider));
    } else if (currentQuestion.questionType == QuestionType.INTEGER) {
      return Expanded(
          child: BasicSolution(
        result: currentQuestion,
        solutionProvider: solutionProvider,
      ));
    } else if (currentQuestion.questionType == QuestionType.NUMERIC) {
      return Expanded(
          child: BasicSolution(
        result: currentQuestion,
        solutionProvider: solutionProvider,
      ));
    } else {
      return const Expanded(
        child: Text("Data not found"),
      );
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
              ref.read(widget.solutionProvider).previous();
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
              ref.read(widget.solutionProvider).solutionImage();
            },
            child: const Text(
              "Solution",
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
              ref.read(widget.solutionProvider).next();
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
    final index = ref.read(widget.solutionProvider).currentQuestionIndex();
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
}
