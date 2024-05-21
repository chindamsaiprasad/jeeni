import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/practice_test_provider.dart';

class CourseList extends ConsumerStatefulWidget {
  const CourseList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourseListState();
}

class _CourseListState extends ConsumerState<CourseList> {
  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(practiceTest).courses.toList();

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c5e20),
          title: const Text(
            "Courses",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return ListTile(
              title: Text(
                course.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              trailing: Radio<Course>(
                value: course,
                groupValue: ref.watch(practiceTest).selectedCourse,
                onChanged: (Course? course) {
                  if (course == null) return;
                  ref.read(practiceTest).setSelectedCourse(course);
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
