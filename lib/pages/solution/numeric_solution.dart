import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/utils/constants.dart';

class NumericSolution extends ConsumerWidget {
  final Result result;
  final ChangeNotifierProvider<SolutionProvider> solutionProvider;
  const NumericSolution({
    required this.result,
    required this.solutionProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(result.toString());
    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: ref.read(solutionProvider).showSolutionImage
                          ? result.questionUrl
                          : result.solutionUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[800],
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Correct Answer : ${result.actualAnswer}",
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: result.status == Status.UNATTEMPTED
                        ? Container(
                            color: Colors.grey,
                            child: const Text(
                              "Unattempted",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container(
                            color:
                                result.actualAnswer == result.userSelectedOption
                                    ? Colors.green
                                    : Colors.redAccent,
                            child: Text(
                              "${result.userSelectedOption}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListView _buildOptionButtons(WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return Padding(
          padding: const EdgeInsets.all(1),
          child: SizedBox(
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: (MediaQuery.of(context).size.width / 4) - 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: result.userSelectedOption == null
                          ? Colors.grey[600]
                          : result.userSelectedOption == option
                              ? result.status.getColor()
                              : Colors.grey[600],
                    ),
                    onPressed: () {},
                    child: Text(option),
                  ),
                ),
                // result.answerValidity[index] == true
                //     ? const Positioned(
                //         left: 0,
                //         child: Icon(
                //           size: 40,
                //           color: Colors.green,
                //           IconData(
                //             0xf3fd,
                //             fontFamily: CupertinoIcons.iconFont,
                //             fontPackage: CupertinoIcons.iconFontPackage,
                //           ),
                //         ),
                //       )
                //     : Container()
                if (index >= 0 && index < result.answerValidity.length)
                  result.answerValidity[index] == true
                      ? const Positioned(
                          left: 0,
                          child: Icon(
                            size: 40,
                            color: Colors.green,
                            IconData(
                              0xf3fd,
                              fontFamily: CupertinoIcons.iconFont,
                              fontPackage: CupertinoIcons.iconFontPackage,
                            ),
                          ),
                        )
                      : Container()
                else
                  Container()
              ],
            ),
          ),
        );
      },
    );
  }
}
