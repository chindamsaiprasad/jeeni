import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:jeeni/utils/constants.dart';

class ColumnMatchingSolution extends ConsumerStatefulWidget {
  final Result result;
  final ChangeNotifierProvider<SolutionProvider> solutionProvider;
  const ColumnMatchingSolution({
    required this.result,
    required this.solutionProvider,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ColumnMatchingSolutionState();
}

class _ColumnMatchingSolutionState
    extends ConsumerState<ColumnMatchingSolution> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
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
                      imageUrl:
                          ref.read(widget.solutionProvider).showSolutionImage
                              ? widget.result.questionUrl
                              : widget.result.solutionUrl,
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
        SizedBox(
          height: 35,
          width: double.infinity,
          child: TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
            ),
            onPressed: () {
              setState(() {
                showOptions = !showOptions;
              });
            },
            icon: Icon(
              showOptions ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down,
              color: AppColour.green,
            ),
            label: showOptions
                ? const Text(
                    "Show",
                    style: TextStyle(color: AppColour.green),
                  )
                : const Text(
                    "Hide",
                    style: TextStyle(color: AppColour.green),
                  ),
          ),
        ),
        Column(
          children: [
            AnimatedContainer(
              height: showOptions ? 0 : 160,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeIn,
              child: _buildOptionButtons(ref),
            ),
          ],
        ),
        !showOptions
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.result.status.getColor(),
                  borderRadius:
                      BorderRadius.circular(12), // Adjust the radius as needed
                ),
                child: Text(
                  ref.read(widget.solutionProvider).getActualAnswer(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  ListView _buildOptionButtons(WidgetRef ref) {
    final coloumMatchingAnswer =
        ref.read(widget.solutionProvider).getUserGivenColoumAnswer();

    final actualAnswer = ref.read(widget.solutionProvider).getActualAnswer();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("$option)", style: const TextStyle(fontSize: 18)),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: PQRSOptions.map((e) {
                      return Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Radio<String>(
                              // splashRadius: 5.0,
                              value: e,
                              toggleable: true,
                              groupValue: coloumMatchingAnswer[index],
                              onChanged: (String? value) {
                                // if (value != null) {
                                //   ref
                                //       .read(testProgressProvider)
                                //       .setColoumMatchingAnswer(value, index);
                                // }
                              },
                            ),
                          ),
                          Text(e),
                        ],
                      );
                      // return Row(
                      //   children: [
                      //     Text(e),
                      //     Radio<String>(
                      //       splashRadius: 10.0,
                      //       value: e,
                      //       toggleable: true,
                      //       groupValue: userSelectedOption,
                      //       onChanged: (String? value) {},
                      //     ),
                      //   ],
                      // );
                    }).toList(),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// class ColumnMatchingSolution extends ConsumerWidget {
//   final Result result;
//   final ChangeNotifierProvider<SolutionProvider> solutionProvider;
//   const ColumnMatchingSolution({
//     required this.result,
//     required this.solutionProvider,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Text("data");
//     // return Column(
//     //   children: [
//     //     Expanded(
//     //       child: Stack(
//     //         fit: StackFit.expand,
//     //         children: [
//     //           SingleChildScrollView(
//     //             child: Column(
//     //               children: [
//     //                 CachedNetworkImage(
//     //                   imageUrl: ref.read(solutionProvider).showSolutionImage
//     //                       ? result.questionUrl
//     //                       : result.solutionUrl,
//     //                   placeholder: (context, url) =>
//     //                       const CircularProgressIndicator(),
//     //                   errorWidget: (context, url, error) =>
//     //                       const Icon(Icons.error),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //     Column(
//     //       children: [
//     //         SizedBox(
//     //           height: 35,
//     //           width: double.infinity,
//     //           child: TextButton.icon(
//     //             style: ButtonStyle(
//     //               backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
//     //             ),
//     //             onPressed: () {
//     //               setState(() {
//     //                 showOptions = !showOptions;
//     //               });
//     //             },
//     //             icon: Icon(
//     //               showOptions
//     //                   ? Icons.arrow_drop_up_rounded
//     //                   : Icons.arrow_drop_down,
//     //               color: AppColour.green,
//     //             ),
//     //             label: showOptions
//     //                 ? const Text(
//     //                     "Hide",
//     //                     style: TextStyle(color: AppColour.green),
//     //                   )
//     //                 : const Text(
//     //                     "Show",
//     //                     style: TextStyle(color: AppColour.green),
//     //                   ),
//     //           ),
//     //         ),
//     //         AnimatedContainer(
//     //           height: showOptions ? 0 : 200,
//     //           duration: const Duration(milliseconds: 900),
//     //           curve: Curves.easeIn,
//     //           child: _buildOptionButtons(ref),
//     //         ),
//     //       ],
//     //     ),
//     //   ],
//     // );
  
//   }
// }
