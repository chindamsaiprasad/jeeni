import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/practice_test_provider.dart';

class ChapterList extends ConsumerStatefulWidget {
  const ChapterList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChapterListState();
}

class _ChapterListState extends ConsumerState<ChapterList> {
  @override
  Widget build(BuildContext context) {
    final chapters = ref.watch(practiceTest).chapters.toList();

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
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return ListTile(
              title: Text(
                chapter.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              trailing: Radio<Chapter>(
                value: chapter,
                groupValue: ref.watch(practiceTest).selectedChapter,
                onChanged: (Chapter? chapter) {
                  if (chapter == null) return;
                  ref.read(practiceTest).setSelectedChapter(chapter);
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
