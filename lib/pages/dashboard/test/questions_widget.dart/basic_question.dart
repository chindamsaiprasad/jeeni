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
                child: ClipRRect(
                  child: Text("Clear"),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
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
                      backgroundColor:
                          ref.watch(testProgressProvider).userSelectedOption ==
                                  null
                              ? Colors.grey[600]
                              : ref
                                          .watch(testProgressProvider)
                                          .userSelectedOption ==
                                      option
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
          ),
        ),
      ],
    );
  }
}
