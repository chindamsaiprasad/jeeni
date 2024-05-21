import 'package:jeeni/models/test_download_response.dart';

class PracticeTestResponse extends TestResponse {
  int? id;
  String? name;
  int? courseId;
  int? subjectId;
  List<int>? chapterId;
  int? topicId;
  int? studentId;
  int? durationInMinutes;
  List<QuestionMobileVos>? questionMobileVos;
  List<int>? questionIds;
  List<int>? chapterAndQuestionIds;

  PracticeTestResponse({
    this.id,
    this.name,
    this.courseId,
    this.subjectId,
    this.chapterId,
    this.topicId,
    this.studentId,
    this.durationInMinutes,
    this.questionMobileVos,
    this.questionIds,
    this.chapterAndQuestionIds,
  });

  PracticeTestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseId = json['courseId'];
    subjectId = json['subjectId'];
    chapterId = json['chapterId'].cast<int>();
    topicId = json['topicId'];
    studentId = json['studentId'];
    durationInMinutes = json['durationInMinutes'];
    if (json['questionMobileVos'] != null) {
      questionMobileVos = <QuestionMobileVos>[];
      json['questionMobileVos'].forEach((v) {
        questionMobileVos!.add(QuestionMobileVos.fromJson(v));
      });
    }
    questionIds = json['questionIds'].cast<int>();
    chapterAndQuestionIds = json['chapterAndQuestionIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['courseId'] = courseId;
    data['subjectId'] = subjectId;
    data['chapterId'] = chapterId;
    data['topicId'] = topicId;
    data['studentId'] = studentId;
    data['durationInMinutes'] = durationInMinutes;
    if (questionMobileVos != null) {
      data['questionMobileVos'] =
          questionMobileVos!.map((v) => v.toJson()).toList();
    }
    data['questionIds'] = questionIds;
    data['chapterAndQuestionIds'] = chapterAndQuestionIds;
    return data;
  }
}
