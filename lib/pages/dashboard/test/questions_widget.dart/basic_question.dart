import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/utils/constants.dart';

class BasicQuestion extends ConsumerStatefulWidget {
  final QuestionMobileVos question;
  const BasicQuestion({
    required this.question,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasicQuestionState();
}

class _BasicQuestionState extends ConsumerState<BasicQuestion> {
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
          height: 50,
          child: _buildOptionButtons(ref),
        ),
      ],
    );
  
  }

  ListView _buildOptionButtons(WidgetRef ref) {
    final userSelectedOption =
        ref.watch(testProgressProvider).userSelectedOption;
    print("_buildOptionButtons  $userSelectedOption");
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return Padding(
          padding: const EdgeInsets.all(1),
          child: SizedBox(
            height: 40,
            width: (MediaQuery.of(context).size.width / 4) - 3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: userSelectedOption == null
                    ? Colors.grey[600]
                    : userSelectedOption == option
                        ? Colors.green
                        : Colors.grey[600],
              ),
              onPressed: () {
                ref.read(testProgressProvider).setSelectedOption(option);
              },
              child: Text(option),
            ),
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
