import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/dashboard/test/questions_widget.dart/basic_question.dart';
import 'package:jeeni/providers/test_progress_provider.dart';

class IntegerQuestion extends ConsumerStatefulWidget {
  final QuestionMobileVos question;
  const IntegerQuestion({
    required this.question,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IntegerQuestionState();
}

class _IntegerQuestionState extends ConsumerState<IntegerQuestion> {
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
        Wrap(
          children: List.generate(
            10,
            (index) => InkWell(
              onTap: () {
                print("ONTAP :: $index");
                ref.read(testProgressProvider).setIntegerAnswer(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  alignment: Alignment.center,
                  width: (MediaQuery.of(context).size.width / 5) - 3,
                  height: 40,
                  color: ref.watch(testProgressProvider).userSelectedOption ==
                          null
                      ? Colors.grey[600]
                      : ref.watch(testProgressProvider).userSelectedOption ==
                              index.toString()
                          ? Colors.green
                          : Colors.grey[600],
                  child: Text(
                    "$index",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
