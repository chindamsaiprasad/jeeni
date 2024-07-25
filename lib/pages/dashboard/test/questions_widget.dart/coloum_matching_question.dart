import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/utils/app_colour.dart';
import 'package:jeeni/utils/constants.dart';

class ColoumMatchingQuestion extends ConsumerStatefulWidget {
  final QuestionMobileVos question;
  const ColoumMatchingQuestion({
    required this.question,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasicQuestionState();
}

class _BasicQuestionState extends ConsumerState<ColoumMatchingQuestion> {
  bool showOptions = false;
  @override
  Widget build(BuildContext context) {
    print(widget.question);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      key: Key(widget.question.questionUrl!),
                      imageUrl: widget.question.questionUrl!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: 20,
                right: 20,
                child: ClearButton(),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  showOptions
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down,
                  color: AppColour.green,
                ),
                label: showOptions
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
            AnimatedContainer(
              height: showOptions ? 0 : 160,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeIn,
              child: _buildOptionButtons(ref),
            ),
          ],
        ),

        // SizedBox(
        //   height: 200,
        //   width: MediaQuery.of(context).size.width,
        //   child: _buildOptionButtons(ref),
        // ),
      ],
    );
  }

  ListView _buildOptionButtons(WidgetRef ref) {
    final coloumMatchingAnswer =
        ref.watch(testProgressProvider).getUserGivenColoumAnswer();

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
                                if (value != null) {
                                  ref
                                      .read(testProgressProvider)
                                      .setColoumMatchingAnswer(value, index);
                                }
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

              // Expanded(
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: PQRSOptions.map(
              //       (pqrsOption) => Container(
              //         width: 50,
              //         child: ListTile(
              //           title: Text(pqrsOption),
              //           leading: Radio<String>(
              //             value: pqrsOption,
              //             groupValue: userSelectedOption,
              //             onChanged: (String? value) {
              //               setState(() {
              //                 // userSelectedOption = value;
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //     ).toList(),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

class ClearButton extends ConsumerWidget {
  const ClearButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      backgroundColor: Colors.red[400],
      child: IconButton(
        onPressed: () {
          ref.read(testProgressProvider).clearAnswer();
        },
        icon: const Icon(
          IconData(0xf72e,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage),
        ),
      ),
    );
  }
}

// class ClearButton extends StatelessWidget {
//   const ClearButton({
//     super.key,
//     required this.ref,
//   });

//   final WidgetRef ref;

//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       backgroundColor: Colors.red[400],
//       child: IconButton(
//         onPressed: () {
//           ref.read(testProgressProvider).clearAnswer();
//         },
//         icon: const Icon(
//           IconData(0xf72e,
//               fontFamily: CupertinoIcons.iconFont,
//               fontPackage: CupertinoIcons.iconFontPackage),
//         ),
//       ),
//     );
//   }
// }

class RadioButtonExample extends StatefulWidget {
  @override
  _RadioButtonExampleState createState() => _RadioButtonExampleState();
}

class _RadioButtonExampleState extends State<RadioButtonExample> {
  String _selectedValue = "p"; // Initial selected value

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: PQRSOptions.map(
          (option) => ListTile(
            title: Text(option),
            leading: Radio<String>(
              value: option,
              groupValue: _selectedValue,
              onChanged: (String? value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
            ),
          ),
        ).toList(),
      ),
    );
  }
}
