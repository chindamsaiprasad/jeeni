import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/test_provider.dart';

class TestListPage extends ConsumerStatefulWidget {
  const TestListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestListPageState();
}

class _TestListPageState extends ConsumerState<TestListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text("Test"),
      ),
      body: Column(
        children: [
          const Text("Mock Test"),
          Expanded(
            child: ListView(
              children: ref
                  .read(testProvider)
                  .tests
                  .map(
                    (test) => Text(test.name ?? "empty"),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
