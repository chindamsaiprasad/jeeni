import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/practice_test_provider.dart';

class SubjectList extends ConsumerStatefulWidget {
  const SubjectList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubjectListState();
}

class _SubjectListState extends ConsumerState<SubjectList> {
  @override
  Widget build(BuildContext context) {
    final subjects = ref.watch(practiceTest).subjects.toList();

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text(
            "Subjects",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return ListTile(
              title: Text(
                subject.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              trailing: Radio<Subject>(
                value: subject,
                groupValue: ref.watch(practiceTest).selectedSubject,
                onChanged: (Subject? subject) {
                  if (subject == null) return;
                  ref.read(practiceTest).setSelectedSubject(subject);
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
