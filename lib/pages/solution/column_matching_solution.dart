import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';

class ColumnMatchingSolution extends ConsumerWidget {
  final Result result;
  final ChangeNotifierProvider<SolutionProvider> solutionProvider;
  const ColumnMatchingSolution({
    required this.result,
    required this.solutionProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text("ColumnMatchingSolution");
  }
}
