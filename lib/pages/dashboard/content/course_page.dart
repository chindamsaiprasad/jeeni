import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/response_models/content_response.dart';
import 'package:jeeni/utils/app_colour.dart';

class CoursePage extends ConsumerStatefulWidget {
  final Course course;
  const CoursePage({
    required this.course,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoursePageState();
}

class _CoursePageState extends ConsumerState<CoursePage> {
  List<Subject> subjects = [];
  Subject? selectedSubject;

  @override
  void initState() {
    super.initState();
    subjects = widget.course.subject ?? [];
    selectedSubject = subjects.isNotEmpty ? subjects.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text(
          widget.course.courseName ?? "", 
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: subjects
                  .map(
                    (subject) => InkWell(
                      onTap: () {
                        setState(() {
                          selectedSubject = subject;
                        });
                      },
                      child: Container(
                        height: 10,
                        alignment: Alignment.center,
                        color: selectedSubject!.subjectId == subject.subjectId
                            ? AppColour.mediumGreen
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(subject.subjectName ?? ""),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 18,
              child: ListView(
                children: (selectedSubject?.chapter ?? [])
                    .map(
                      (chapter) => Card(
                        elevation: 5,
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Text(chapter.chapterName ?? ""),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ))
        ],
      ),
    );
  }
}
