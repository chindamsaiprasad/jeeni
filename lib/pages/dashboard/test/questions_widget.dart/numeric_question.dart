import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/basic_question.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/utils/app_colour.dart';

class NumericQuestion extends ConsumerStatefulWidget {
  final QuestionMobileVos question;
  const NumericQuestion({
    required this.question,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NumericQuestionState();
}

class _NumericQuestionState extends ConsumerState<NumericQuestion> {
  // late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    // _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // _textEditingController.dispose();
    super.dispose();
  }

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
              // const Positioned(
              //   bottom: 20,
              //   right: 20,
              //   child: ClearButton(),
              // )
            ],
          ),
        ),
        Container(
          height: 50,
          color: AppColour.darkGrey,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextField(
              focusNode: ref.read(testProgressProvider).focusNode,
              controller: ref.read(testProgressProvider).textEditingController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              // onChanged: (value) {
              //   print("VALUE $value");
              //   ref.read(testProgressProvider).setNumericAnswer(value);
              // },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Answer',
                border: OutlineInputBorder(
                  // Defines border
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              // decoration: InputDecoration(
              //   border: InputBorder.none,
              //   labelText: 'Enter Answer',
              // ),
            ),
          ),
        )
      ],
    );
  }
}
