import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/practice_test/chapter_list.dart';
import 'package:jeeni/pages/dashboard/practice_test/course_list.dart';
import 'package:jeeni/pages/dashboard/practice_test/subject_list.dart';
import 'package:jeeni/pages/dashboard/practice_test/topic_list.dart';
import 'package:jeeni/pages/dashboard/test/result_page.dart';
import 'package:jeeni/pages/dashboard/test/test_page.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/practice_test_provider.dart';
import 'package:jeeni/response_models/submit_test_response.dart';
import 'package:jeeni/utils/app_colour.dart';

class PracticeTest extends ConsumerWidget {
  const PracticeTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Material(
            elevation: 10,
            child: InkWell(
              onTap: () {
                OverlayLoader.show(context: context, title: "Loading Courses");
                ref
                    .read(practiceTest)
                    .getSubscriptions()
                    .then((isSucess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CourseList();
                          },
                        ),
                      ).then((isSelected) {
                        if (isSelected) {
                          OverlayLoader.show(
                            context: context,
                            title: "Loading Subjects",
                          );
                          ref
                              .read(practiceTest)
                              .getAllSubjectsByCourse()
                              .then((isSucess) {
                                if (isSucess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const SubjectList();
                                      },
                                    ),
                                  ).then((isSelectedSubject) {
                                    if (isSelectedSubject) {
                                      OverlayLoader.show(
                                          context: context,
                                          title: "Loading Chapters");
                                      ref
                                          .read(practiceTest)
                                          .getByCourseAndSubject()
                                          .then((isSucess) {
                                            if (isSucess) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const ChapterList();
                                                  },
                                                ),
                                              );
                                            }
                                          })
                                          .catchError((error) {})
                                          .whenComplete(
                                              () => OverlayLoader.hide());
                                    }
                                  });
                                }
                              })
                              .catchError((error) {})
                              .whenComplete(() => OverlayLoader.hide());
                        }
                      });
                    })
                    .catchError((error) {})
                    .whenComplete(() => OverlayLoader.hide());
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ref.watch(practiceTest).selectedCourse == null
                          ? const Text(
                              "Select Course",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Text.rich(
                              TextSpan(
                                text: "Select Course\n",
                                style: const TextStyle(
                                  color: AppColour.mediumGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: ref
                                        .read(practiceTest)
                                        .selectedCourse
                                        ?.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      const Icon(
                        Icons.menu_book_sharp,
                        size: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: ref.read(practiceTest).selectedCourse == null
                ? null
                : () {
                    OverlayLoader.show(
                      context: context,
                      title: "Loading Subjects",
                    );
                    ref
                        .read(practiceTest)
                        .getAllSubjectsByCourse()
                        .then((isSucess) {
                          if (isSucess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SubjectList();
                                },
                              ),
                            ).then((isSelectedSubject) {
                              if (isSelectedSubject) {
                                OverlayLoader.show(
                                    context: context,
                                    title: "Loading Chapters");
                                ref
                                    .read(practiceTest)
                                    .getByCourseAndSubject()
                                    .then((isSucess) {
                                      if (isSucess) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const ChapterList();
                                            },
                                          ),
                                        );
                                      }
                                    })
                                    .catchError((error) {})
                                    .whenComplete(() => OverlayLoader.hide());
                              }
                            });
                          }
                        })
                        .catchError((error) {})
                        .whenComplete(() => OverlayLoader.hide());
                  },
            child: Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ref.read(practiceTest).selectedSubject == null
                        ? Text(
                            "Select Subject",
                            style: TextStyle(
                              color:
                                  ref.watch(practiceTest).selectedCourse == null
                                      ? Colors.black
                                      : Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text.rich(
                            TextSpan(
                              text: "Select Subject\n",
                              style: const TextStyle(
                                color: AppColour.mediumGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ref
                                      .read(practiceTest)
                                      .selectedSubject
                                      ?.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                    const Icon(
                      Icons.menu_book_sharp,
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: ref.read(practiceTest).selectedSubject == null
                ? null
                : () {
                    OverlayLoader.show(
                        context: context, title: "Loading Chapters");
                    ref
                        .read(practiceTest)
                        .getByCourseAndSubject()
                        .then((isSucess) {
                          if (isSucess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ChapterList();
                                },
                              ),
                            );
                          }
                        })
                        .catchError((error) {})
                        .whenComplete(() => OverlayLoader.hide());
                  },
            child: Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ref.read(practiceTest).selectedChapter == null
                        ? Text(
                            "Select Chapter",
                            style: TextStyle(
                              color: ref.watch(practiceTest).selectedSubject ==
                                      null
                                  ? Colors.black
                                  : Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text.rich(
                            TextSpan(
                              text: "Select Chapter\n",
                              style: const TextStyle(
                                color: AppColour.mediumGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ref
                                      .read(practiceTest)
                                      .selectedChapter
                                      ?.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                    const Icon(
                      Icons.menu_book_sharp,
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: ref.read(practiceTest).selectedCourse == null &&
                    ref.read(practiceTest).selectedSubject == null &&
                    ref.read(practiceTest).selectedChapter == null
                ? null
                : () {
                    OverlayLoader.show(
                      context: context,
                      title: "Loading Topics",
                    );
                    ref
                        .read(practiceTest)
                        .getTopicByChapter()
                        .then((isSucess) {
                          if (isSucess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const TopicList();
                                },
                              ),
                            );
                          }
                        })
                        .catchError((error) {})
                        .whenComplete(() => OverlayLoader.hide());
                  },
            child: Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ref.read(practiceTest).selectedTopic == null
                        ? Text(
                            "Select Topic(Optional)",
                            style: TextStyle(
                              color:
                                  ref.watch(practiceTest).selectedTopic == null
                                      ? Colors.black
                                      : Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text.rich(
                            TextSpan(
                              text: "Select Topic(Optional)\n",
                              style: const TextStyle(
                                color: AppColour.mediumGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ref
                                      .read(practiceTest)
                                      .selectedTopic
                                      ?.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                    const Icon(
                      Icons.menu_book_sharp,
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xff1c5e20)),
            ),
            onPressed: ref.read(practiceTest).selectedCourse == null &&
                    ref.read(practiceTest).selectedSubject == null &&
                    ref.read(practiceTest).selectedChapter == null
                ? null
                : () {
                    OverlayLoader.show(context: context, title: "Loading");
                    ref
                        .read(practiceTest)
                        .fetchPracticeTest()
                        .then((response) {
                          OverlayLoader.hide();
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TestPage(testDownloadResponse: response),
                            ),
                          ).then((value) {
                            if (value is SubmitTestResponse) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResultPage(submitTestResponse: value),
                                ),
                              );
                            }
                          });
                        })
                        .catchError((onError) {})
                        .whenComplete(() => OverlayLoader.hide());
                  },
            child: const Text("Start Test"),
          ),
        ),
      
      ],
    );
  }
}
