import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/test_download_response.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.question.questionUrl!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),
        ),
        Wrap(
          children: List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width / 5) - 3,
                height: 40,
                color: Colors.grey[600],
                child: Text(
                  "$index",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
