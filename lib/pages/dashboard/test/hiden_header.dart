import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:provider/provider.dart';

class HidenHeader extends ConsumerStatefulWidget {
  const HidenHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HidenHeaderState();
}

class _HidenHeaderState extends ConsumerState<HidenHeader> {
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final currentQuestion = ref.watch(testProgressProvider).getCurrentQuestion;
    return Column(
      children: [
        // Selector<TestProgressProvider, bool>(
        //     selector: (_, provider) => provider.hasHide,
        //     builder: (context, number1, child) {
        //       print('Build num1');
        //       return Container(
        //         color: Colors.red,
        //         padding: EdgeInsets.all(10),
        //         child: Text('$number1'),
        //       );
        //     }),
        AnimatedContainer(
          height: !ref.read(testProgressProvider).getHasHiden ? 0 : 90,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: ref.read(testProgressProvider).getHasHiden
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
        ),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
            ),
            onPressed: () {
              if (ref.read(testProgressProvider).getHasHiden) {
                ref.read(testProgressProvider).hide();
              } else {
                ref.read(testProgressProvider).show();
              }
            },
            icon: Icon(
              ref.read(testProgressProvider).getHasHiden
                  ? Icons.arrow_drop_up_rounded
                  : Icons.arrow_drop_down,
              color: AppColour.green,
            ),
            label: ref.read(testProgressProvider).getHasHiden
                ? const Text(
                    "Hide",
                    style: TextStyle(color: AppColour.green),
                  )
                : const Text(
                    "Show",
                    style: TextStyle(color: AppColour.green),
                  ),
          ),
        ),
     
      ],
    );
  }
}
