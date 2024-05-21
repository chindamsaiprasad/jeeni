import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/practice_test_provider.dart';

class TopicList extends ConsumerStatefulWidget {
  const TopicList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopicListState();
}

class _TopicListState extends ConsumerState<TopicList> {
  @override
  Widget build(BuildContext context) {
    final topics = ref.watch(practiceTest).topics.toList();

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text(
            "Chapters",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return ListTile(
              title: Text(
                topic.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              trailing: Radio<Topic>(
                value: topic,
                groupValue: ref.watch(practiceTest).selectedTopic,
                onChanged: (Topic? topic) {
                  if (topic == null) return;
                  ref.read(practiceTest).setSelectedTopic(topic);
                  Navigator.pop(context, true);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
