// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/response_models/practice_test_response.dart';
import 'package:jeeni/response_models/submit_test_response.dart';
import 'package:jeeni/utils/file_utils.dart';

final practiceTest =
    ChangeNotifierProvider((ref) => PracticeTestProvider(ref: ref));

class PracticeTestProvider with ChangeNotifier {
  Iterable<Course> courses = [];
  Course? _selectedCourse;

  Iterable<Subject> subjects = [];
  Subject? _selectedSubject;

  Iterable<Chapter> chapters = [];
  Chapter? _selectedChapter;

  Iterable<Topic> topics = [];
  Topic? _selectedTopic;

  final Ref ref;

  PracticeTestProvider({required this.ref});

  Course? get selectedCourse => _selectedCourse;
  Subject? get selectedSubject => _selectedSubject;
  Chapter? get selectedChapter => _selectedChapter;
  Topic? get selectedTopic => _selectedTopic;

  Future<bool> getSubscriptions() async {
    // const url = "https://exam.jeeni.in/Jeeni/rest/course/getSubscriptions";
    final jauth = ref.read(authenticationProvider)?.jauth;
    Map<String, String> headers = {};

    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/json",
      "Jauth": jauth!
    });
    return await http
        .get(Uri.parse("$BASE_URL/course/getSubscriptions"), headers: headers)
        .then((response) {
      var responseData = json.decode(response.body) as List;
      courses = responseData.map((e) => Course.fromJson(e));
      return true;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: FETCH TEST");
      throw Exception(error);
    });
  }

  void setSelectedCourse(Course? course) {
    if (_selectedCourse?.id != course?.id) {
      _selectedCourse = course;
      subjects = [];
      chapters = [];
      _selectedSubject = null;
      _selectedChapter = null;
      _selectedTopic = null;
      notifyListeners();
    }
  }

  void setSelectedSubject(Subject subject) {
    if (_selectedSubject?.id != subject.id) {
      _selectedSubject = subject;
      chapters = [];
      _selectedChapter = null;
      _selectedTopic = null;
      notifyListeners();
    }
  }

  void setSelectedChapter(Chapter chapter) {
    if (_selectedChapter?.id != chapter.id) {
      _selectedChapter = chapter;
      _selectedTopic = null;
      notifyListeners();
    }
  }

  void setSelectedTopic(Topic topic) {
    _selectedTopic = topic;
    notifyListeners();
  }

  Future<bool> getAllSubjectsByCourse() async {
    final jauth = ref.read(authenticationProvider)?.jauth;
    Map<String, String> headers = {};
//url = "https://exam.jeeni.in/Jeeni/rest/subject/getByCourse/32"
    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/json",
      "Jauth": jauth!
    });
    return await http
        .get(Uri.parse("$BASE_URL/subject/getByCourse/${_selectedCourse?.id}"),
            headers: headers)
        .then((response) {
      print("RESPONSE :: ${response.body}");
      var responseData = json.decode(response.body) as List;
      subjects = responseData.map((e) => Subject.fromJson(e));
      return true;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: FETCH TEST");
      throw Exception(error);
    });
  }

  Future<bool> getByCourseAndSubject() async {
    final jauth = ref.read(authenticationProvider)?.jauth;
    Map<String, String> headers = {};
//url = "https://exam.jeeni.in/Jeeni/rest/chapter/getByCourseAndSubject/32/2"
    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/json",
      "Jauth": jauth!
    });

    return await http
        .get(
            Uri.parse(
                "$BASE_URL/chapter/getByCourseAndSubject/${_selectedCourse?.id}/${_selectedSubject?.id}"),
            headers: headers)
        .then((response) {
      print("RESPONSE :: ${response.body}");
      var responseData = json.decode(response.body) as List;
      chapters = responseData.map((e) => Chapter.fromJson(e));
      return true;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: FETCH TEST");
      throw Exception(error);
    });
  }

  Future<bool> getTopicByChapter() async {
    final jauth = ref.read(authenticationProvider)?.jauth;
    Map<String, String> headers = {};
//url = "https://exam.jeeni.in/Jeeni/rest/chapter/getByCourseAndSubject/32/2"
    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/json",
      "Jauth": jauth!
    });

    return await http
        .get(Uri.parse("$BASE_URL/topic/getByChapter/${_selectedChapter?.id}"),
            headers: headers)
        .then((response) {
      print("RESPONSE :: ${response.body}");
      var responseData = json.decode(response.body) as List;
      topics = responseData.map((e) => Topic.fromJson(e));
      return true;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: FETCH TEST");
      throw Exception(error);
    });
  }

  Future<PracticeTestResponse> fetchPracticeTest() async {
    final jauth = ref.read(authenticationProvider)?.jauth;
    Map<String, String> headers = {};
//url = "https://exam.jeeni.in/Jeeni/rest/testmgmt/get"
    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
      "Jauth": jauth!
    });

    final jsonData = {
      "chapterId": [_selectedChapter?.id ?? 0],
      "courseId": _selectedCourse?.id ?? 0,
      "durationInMinutes": 0,
      "id": 0,
      "studentId": 0,
      "subjectId": _selectedSubject?.id ?? 0,
      "topicId": _selectedTopic?.id ?? 0
    };

    String jsonString = jsonEncode(jsonData);

    final body = {
      "deviceHeight": 2180.toString(),
      "deviceWidth": 1080.toString(),
      "practiceTestDataVo": jsonString
    };

    return await http
        .post(
      Uri.parse("$BASE_URL/testmgmt/get"),
      headers: headers,
      body: body,
    )
        .then((response) {
      print("RESPONSE :: ${response.body}");
      Map<String, dynamic> data = json.decode(response.body);
      return PracticeTestResponse.fromJson(data);
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: PRACTICE FETCH TEST");
      throw Exception(error);
    });
  }

  Future<SubmitTestResponse> submitPracticeTest(
      {required TestResultRequest testResultRequest}) async {
    final jauth = ref.read(authenticationProvider)?.jauth;
    Map<String, String> headers = {};
    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
      "Jauth": jauth!
    });

    final body = {
      // "correctAnswers": 0,
      // "isAutoSubmit": false,
      // "isLogActive": false,
      "questionResult": testResultRequest.questionResult != null
          ? testResultRequest.questionResult!
              .map(
                (e) => {
                  "questionId": e.questionId,
                  "status": e.status,
                  "timeTaken": e.timeTaken,
                  // "userGivenAnswers": e.userGivenAnswers,
                  "userSelectedOption": e.userSelectedOption
                },
              )
              .toList()
          : [],
      "testId": testResultRequest.testId,
      // "totalQuestions": 0,
      // "unAttemptedQuestions": 0
    };

    String jsonString = jsonEncode(body);
    return await http.post(Uri.parse("$BASE_URL/testmgmt/submitResult"),
        headers: headers, body: {"testResult": jsonString}).then((response) {
      print("RESPONSE PRACTICE TEST:: ${response.body}");
      Map<String, dynamic> data = json.decode(response.body);

      // FileUtils.writeJsonToFile(data, "assets/res.json");
      // return response.body;
      final res = SubmitTestResponse.fromJson(data);
      print("unAttemptedQuestions :: ${res.unAttemptedQuestions}");
      print("correctAnswers       :: ${res.correctAnswers}");
      print("inCorrectAnswer      :: ${res.inCorrectAnswer}");
      print("totalQuestions       :: ${res.totalQuestions}");
      print("${res.unAttemptedQuestions}");
      print("${res.unAttemptedQuestions}");
      return res;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: FETCH TEST");
      throw Exception(error);
    });
  }
}

class Course {
  int? id;
  String? name;
  int? subjectIds;
  int? chapterIds;
  int? status;
  int? orgId;

  Course({
    this.id,
    this.name,
    this.subjectIds,
    this.chapterIds,
    this.status,
    this.orgId,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subjectIds = json['subjectIds'];
    chapterIds = json['chapterIds'];
    status = json['status'];
    orgId = json['orgId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['subjectIds'] = subjectIds;
    data['chapterIds'] = chapterIds;
    data['status'] = status;
    data['orgId'] = orgId;
    return data;
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        subjectIds.hashCode ^
        chapterIds.hashCode ^
        status.hashCode ^
        orgId.hashCode;
  }
}

class Subject {
  int? id;
  String? name;
  int? courseIds;
  int? chapterIds;

  Subject({this.id, this.name, this.courseIds, this.chapterIds});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseIds = json['courseIds'];
    chapterIds = json['chapterIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['courseIds'] = courseIds;
    data['chapterIds'] = chapterIds;
    return data;
  }
}

class Chapter {
  int? id;
  String? name;
  int? courseIds;
  int? subjectId;
  int? topicIds;

  Chapter({
    this.id,
    this.name,
    this.courseIds,
    this.subjectId,
    this.topicIds,
  });

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseIds = json['courseIds'];
    subjectId = json['subjectId'];
    topicIds = json['topicIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['courseIds'] = courseIds;
    data['subjectId'] = subjectId;
    data['topicIds'] = topicIds;
    return data;
  }
}

class Topic {
  int? id;
  String? name;
  int? chapterId;

  Topic({
    this.id,
    this.name,
    this.chapterId,
  });

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    chapterId = json['chapterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['chapterId'] = chapterId;
    return data;
  }
}
