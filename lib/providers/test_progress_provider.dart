// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:jeeni/enums/answer_status.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/providers/practice_test_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/response_models/practice_test_response.dart';
import 'package:jeeni/response_models/submit_test_response.dart';

final testProgressProvider =
    ChangeNotifierProvider((ref) => TestProgressProvider(ref: ref));

class TestProgressProvider with ChangeNotifier {
  late TestResponse testResponse;
  late int testId = -1;
  List<QuestionMobileVos> questions = [];

  QuestionMobileVos? _currentQuestion;
  Timer? _timer;
  int _remaingDurationInSeconds = 0;
  bool isLoading = false;
  bool _hasHide = true;

  final Ref ref;
  TestProgressProvider({
    required this.ref,
  });

  List<QuestionMobileVos> get getQuestion => questions;
  int get getQuestionCount => questions.length;

  int get getremaingDurationInSeconds => _remaingDurationInSeconds;
  String? get userSelectedOption => _currentQuestion?.userSelectedOption;
  bool get getIsLoading => isLoading;
  bool get getHasHiden => _hasHide;

  QuestionMobileVos? get getCurrentQuestion => _currentQuestion;

  int currentQuestionIndex() {
    final currentQuestion = getCurrentQuestion;
    if (currentQuestion == null) return -1;
    return [...questions]
        .indexWhere((question) => question.id == currentQuestion.id);
  }

  void _reset() {
    _hasHide = true;
    Future.delayed(
      const Duration(seconds: 2),
      () {
        _hasHide = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    print("disposedisposedisposedispose");
    _timer?.cancel();
    super.dispose();
  }

  void init(TestResponse testResponse) {
    isLoading = true;
    notifyListeners();
    this.testResponse = testResponse;

    if (testResponse is TestDownloadResponse) {
      questions = testResponse.questionMobileVos ?? [];
      testId = testResponse.id ?? -1;
    } else if (testResponse is PracticeTestResponse) {
      questions = testResponse.questionMobileVos ?? [];
      testId = testResponse.id ?? -1;
    }

    if (questions.isNotEmpty) {
      _currentQuestion = questions.first.copyWith();
    }
    isLoading = false;
    //initTimer();
    _reset();
    notifyListeners();
  }

  void initTimer() {
    // _remaingDurationInSeconds =
    //     (testDownloadResponse.durationInMinutes ?? 0) * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remaingDurationInSeconds++;
      if (_remaingDurationInSeconds == 0) {}
      notifyListeners();
    });
  }

  void next() {
    final currentQuestion = getCurrentQuestion;
    if (currentQuestion == null) return;
    final tempList = [...questions];
    var index =
        tempList.indexWhere((question) => question.id == currentQuestion.id);

    index = index + 1;
    if ((index) < tempList.length) {
      _currentQuestion = tempList.elementAt(index).copyWith();
    } else {
      _currentQuestion = tempList.first.copyWith();
    }
    _reset();
    notifyListeners();
  }

  void previous() {
    final currentQuestion = getCurrentQuestion;
    if (currentQuestion == null) return;

    final tempList = [...questions];
    var index =
        tempList.indexWhere((question) => question.id == currentQuestion.id);

    index = index - 1;
    if ((index) >= 0) {
      _currentQuestion = tempList.elementAt(index).copyWith();
    } else {
      _currentQuestion = tempList.last.copyWith();
    }
    notifyListeners();
  }

  void markForReview() {
    if (_currentQuestion == null) return;

    if (_currentQuestion?.userSelectedOption == null) {
      _currentQuestion = _currentQuestion?.copyWith(
        customAnswerStatus: AnswerStatus.MARK_FOR_REVIEW,
      );
    } else {
      _currentQuestion = _currentQuestion?.copyWith(
        customAnswerStatus: AnswerStatus.ANSWERED_AND_MARK_FOR_REVIEW,
      );
    }
    final index = currentQuestionIndex();
    questions.removeAt(index);
    questions.insert(index, _currentQuestion!);
    next();
  }

  void setSelectedOption(String selectedOption) {
    if (_currentQuestion == null) return;
    // currentQuestion?.userSelectedOption = selectedOption;
    _currentQuestion = _currentQuestion?.copyWith(
      userSelectedOption: selectedOption,
      customAnswerStatus: AnswerStatus.ANSWERED,
    );

    final index = currentQuestionIndex();
    questions.removeAt(index);
    questions.insert(index, _currentQuestion!);
    notifyListeners();
  }

  void hide() {
    _hasHide = false;
    notifyListeners();
  }

  void show() {
    _hasHide = true;
    notifyListeners();
  }

  Future<SubmitTestResponse?> submitTest() async {
    final questionResult = questions.map(
      (question) {
        final userGivenAnswers = [false, false, false, false];
        question = question.copyWith(userSelectedOption: "A");
        if (question.questionType == "Basic") {
          if (question.userSelectedOption != null) {
            if (question.userSelectedOption == "A") {
              userGivenAnswers[0] = true;
            }
            if (question.userSelectedOption == "B") {
              userGivenAnswers[1] = true;
            }
            if (question.userSelectedOption == "C") {
              userGivenAnswers[2] = true;
            }
            if (question.userSelectedOption == "D") {
              userGivenAnswers[3] = true;
            }
          }
        }
        return QuestionResult(
          questionId: question.id!,
          userGivenAnswers: userGivenAnswers,
          timeTaken: 0,
          status: 0,
          userSelectedOption: question.userSelectedOption,
        );
      },
    ).toList();

    final testResultRequest = TestResultRequest(
      correctAnswers: 0,
      isAutoSubmit: false,
      isLogActive: false,
      totalQuestions: 0,
      unAttemptedQuestions: 0,
      testId: testId,
      questionResult: questionResult,
    );

    if (testResponse is TestDownloadResponse) {
      return await ref
          .read(testProvider)
          .submitTest(testResultRequest: testResultRequest);
    } else if (testResponse is PracticeTestResponse) {
      return await ref
          .read(practiceTest)
          .submitPracticeTest(testResultRequest: testResultRequest);
    }
    return null;
  }
}

// class TestResultRequest
class TestResultRequest {
  int? correctAnswers;
  bool? isAutoSubmit;
  bool? isLogActive;
  List<QuestionResult>? questionResult;
  int? testId;
  int? totalQuestions;
  int? unAttemptedQuestions;

  TestResultRequest(
      {this.correctAnswers,
      this.isAutoSubmit,
      this.isLogActive,
      this.questionResult,
      this.testId,
      this.totalQuestions,
      this.unAttemptedQuestions});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'correctAnswers': correctAnswers,
      'isAutoSubmit': isAutoSubmit,
      'isLogActive': isLogActive,
      'questionResult': questionResult?.map((x) => x.toMap()).toList(),
      'testId': testId,
      'totalQuestions': totalQuestions,
      'unAttemptedQuestions': unAttemptedQuestions,
    };
  }

  factory TestResultRequest.fromMap(Map<String, dynamic> map) {
    return TestResultRequest(
      correctAnswers:
          map['correctAnswers'] != null ? map['correctAnswers'] as int : null,
      isAutoSubmit:
          map['isAutoSubmit'] != null ? map['isAutoSubmit'] as bool : null,
      isLogActive:
          map['isLogActive'] != null ? map['isLogActive'] as bool : null,
      questionResult: map['questionResult'] != null
          ? List<QuestionResult>.from(
              (map['questionResult'] as List<int>).map<QuestionResult?>(
                (x) => QuestionResult.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      testId: map['testId'] != null ? map['testId'] as int : null,
      totalQuestions:
          map['totalQuestions'] != null ? map['totalQuestions'] as int : null,
      unAttemptedQuestions: map['unAttemptedQuestions'] != null
          ? map['unAttemptedQuestions'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestResultRequest.fromJson(String source) =>
      TestResultRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

class QuestionResult {
  int? questionId;
  int? status;
  int? timeTaken;
  List<bool>? userGivenAnswers;
  String? userSelectedOption;

  QuestionResult(
      {this.questionId,
      this.status,
      this.timeTaken,
      this.userGivenAnswers,
      this.userSelectedOption});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'status': status,
      'timeTaken': timeTaken,
      'userGivenAnswers': userGivenAnswers,
      'userSelectedOption': userSelectedOption,
    };
  }

  factory QuestionResult.fromMap(Map<String, dynamic> map) {
    return QuestionResult(
      questionId: map['questionId'] != null ? map['questionId'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
      timeTaken: map['timeTaken'] != null ? map['timeTaken'] as int : null,
      userGivenAnswers: map['userGivenAnswers'] != null
          ? List<bool>.from((map['userGivenAnswers'] as List<bool>))
          : null,
      userSelectedOption: map['userSelectedOption'] != null
          ? map['userSelectedOption'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionResult.fromJson(String source) =>
      QuestionResult.fromMap(json.decode(source) as Map<String, dynamic>);
}
