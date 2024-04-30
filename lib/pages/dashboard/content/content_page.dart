import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/content/course_page.dart';
import 'package:jeeni/providers/content_provider.dart';
import 'package:jeeni/response_models/content_response.dart';

class ContentPage extends ConsumerStatefulWidget {
  const ContentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentPageState();
}

class _ContentPageState extends ConsumerState<ContentPage> {
  List<Course>? courses;
  @override
  void initState() {
    super.initState();
    courses = ref.read(contentProvider).contentResponse.course;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Text("data"),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text("My Content"),
      ),
      body: courses != null
          ? ListView(
              children: courses!
                  .map(
                    (course) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CoursePage(course: course),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: MediaQuery.of(context).size.width - 20,
                            child: Text(course.courseName ?? ""),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList())
          : const Text(""),
    );
  }
}
