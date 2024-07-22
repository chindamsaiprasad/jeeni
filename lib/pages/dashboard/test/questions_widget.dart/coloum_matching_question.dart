import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    print(widget.question);
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
        SizedBox(
          height: 200,
          child: _buildOptionButtons(ref),
        ),
      ],
    );
  }

  ListView _buildOptionButtons(WidgetRef ref) {
    final userSelectedOption =
        ref.watch(testProgressProvider).userSelectedOption;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            color: Colors.amber,
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Text("data"),
            // child: Row(
            //   children: PQRSOptions.map(
            //     (option) => ListTile(
            //       title: Text(option),
            //       leading: Radio<String>(
            //         value: option,
            //         groupValue: userSelectedOption,
            //         onChanged: (String? value) {},
            //       ),
            //     ),
            //   ).toList(),
            // ),
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
