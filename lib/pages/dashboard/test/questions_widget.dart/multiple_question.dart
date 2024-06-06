// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/basic_question.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/utils/constants.dart';

class MultipleQuestion extends ConsumerStatefulWidget {
  final QuestionMobileVos question;
  const MultipleQuestion({
    super.key,
    required this.question,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultipleQuestionState();
}

class _MultipleQuestionState extends ConsumerState<MultipleQuestion> {
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
    final multipleAnswer = ref.watch(testProgressProvider).multipleAnswer;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        print("1111111111111111111111111");
        print(multipleAnswer[index]);
        return Padding(
          padding: const EdgeInsets.all(1),
          child: SizedBox(
            height: 40,
            width: (MediaQuery.of(context).size.width / 4) - 3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    multipleAnswer[index] ? Colors.green : Colors.grey[600],
              ),
              onPressed: () {
                ref.read(testProgressProvider).setMultipleOption(option);
              },
              child: Text(option),
            ),
          ),
        );
      },
    );
  }
}
