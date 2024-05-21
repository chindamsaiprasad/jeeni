import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: Text("NumericQuestion"),
        ),
        Container(
          height: 50,
          color: AppColour.darkGrey,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextField(
              textAlign: TextAlign.center,
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
