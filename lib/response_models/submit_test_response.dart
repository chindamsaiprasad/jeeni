import 'dart:convert';

import 'package:jeeni/models/test_download_response.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubmitTestResponse {
  int? testId;
  List<QuestionMobileVos>? questions;
  List<QuestionResult>? questionResult;
  int? totalQuestions;
  int? correctAnswers;
  int? unAttemptedQuestions;
  double? score;
  double? outOfScore;
  int? batchId;
  Null? logActivity;
  int? studentId;
  int? inCorrectAnswer;
  double? bonus;
  Null? testLogVo;
  int? partialCorrect;
  int? attemptedQuestions;
  int? createdOn;
  int? rank;
  int? syncStatus;
  bool? resultShowHide;
  bool? partialResult;
  bool? autoSubmit;
  bool? logActive;
  List<int>? questionIds;

  SubmitTestResponse({
    this.testId,
    this.questions,
    this.questionResult,
    this.totalQuestions,
    this.correctAnswers,
    this.unAttemptedQuestions,
    this.score,
    this.outOfScore,
    this.batchId,
    this.logActivity,
    this.studentId,
    this.inCorrectAnswer,
    this.bonus,
    this.testLogVo,
    this.partialCorrect,
    this.attemptedQuestions,
    this.createdOn,
    this.rank,
    this.syncStatus,
    this.resultShowHide,
    this.partialResult,
    this.autoSubmit,
    this.logActive,
    this.questionIds,
  });

  // SubmitTestResponse({
  //   this.testId,
  //   this.questionResult,
  //   this.totalQuestions,
  //   this.correctAnswers,
  //   this.unAttemptedQuestions,
  //   this.score,
  //   this.outOfScore,
  //   this.batchId,
  //   this.logActivity,
  //   this.studentId,
  //   this.inCorrectAnswer,
  //   this.bonus,
  //   this.testLogVo,
  //   this.partialCorrect,
  //   this.attemptedQuestions,
  //   this.createdOn,
  //   this.rank,
  //   this.syncStatus,
  //   this.resultShowHide,
  //   this.partialResult,
  //   this.autoSubmit,
  //   this.logActive,
  //   this.questionIds,
  // });

  SubmitTestResponse.fromJson(Map<String, dynamic> json) {
    testId = json['testId'];

    totalQuestions = json['totalQuestions'];
    correctAnswers = json['correctAnswers'];
    print("unAttemptedQuestions   :: ${json['unAttemptedQuestions']}");
    unAttemptedQuestions = json['unAttemptedQuestions'];
    score = json['score'];
    outOfScore = json['outOfScore'];
    batchId = json['batchId'];
    logActivity = json['logActivity'];
    studentId = json['studentId'];
    inCorrectAnswer = json['inCorrectAnswer'];
    bonus = json['bonus'];
    testLogVo = json['testLogVo'];
    partialCorrect = json['partialCorrect'];
    attemptedQuestions = json['attemptedQuestions'];
    createdOn = json['createdOn'];
    rank = json['rank'];
    syncStatus = json['syncStatus'];
    resultShowHide = json['resultShowHide'];
    partialResult = json['partialResult'];
    autoSubmit = json['autoSubmit'];
    logActive = json['logActive'];
    if (json['questionResult'] != null) {
      questionResult = <QuestionResult>[];
      json['questionResult'].forEach((v) {
        questionResult!.add(QuestionResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testId'] = testId;
    if (questionResult != null) {
      data['questionResult'] = questionResult!.map((v) => v.toJson()).toList();
    }
    data['totalQuestions'] = totalQuestions;
    data['correctAnswers'] = correctAnswers;
    data['unAttemptedQuestions'] = unAttemptedQuestions;
    data['score'] = score;
    data['outOfScore'] = outOfScore;
    data['batchId'] = batchId;
    data['logActivity'] = logActivity;
    data['studentId'] = studentId;
    data['inCorrectAnswer'] = inCorrectAnswer;
    data['bonus'] = bonus;
    data['testLogVo'] = testLogVo;
    data['partialCorrect'] = partialCorrect;
    data['attemptedQuestions'] = attemptedQuestions;
    data['createdOn'] = createdOn;
    data['rank'] = rank;
    data['syncStatus'] = syncStatus;
    data['resultShowHide'] = resultShowHide;
    data['partialResult'] = partialResult;
    data['autoSubmit'] = autoSubmit;
    data['logActive'] = logActive;
    return data;
  }

  // SubmitTestResponse copyWith({
  //   int? testId,
  //   List<QuestionResult>? questionResult,
  //   int? totalQuestions,
  //   int? correctAnswers,
  //   int? unAttemptedQuestions,
  //   double? score,
  //   double? outOfScore,
  //   int? batchId,
  //   Null? logActivity,
  //   int? studentId,
  //   int? inCorrectAnswer,
  //   double? bonus,
  //   Null? testLogVo,
  //   int? partialCorrect,
  //   int? attemptedQuestions,
  //   int? createdOn,
  //   int? rank,
  //   int? syncStatus,
  //   bool? resultShowHide,
  //   bool? partialResult,
  //   bool? autoSubmit,
  //   bool? logActive,
  //   List<int>? questionIds,
  // }) {
  //   return SubmitTestResponse(
  //     testId: testId ?? this.testId,
  //     questionResult: questionResult ?? this.questionResult,
  //     totalQuestions: totalQuestions ?? this.totalQuestions,
  //     correctAnswers: correctAnswers ?? this.correctAnswers,
  //     unAttemptedQuestions: unAttemptedQuestions ?? this.unAttemptedQuestions,
  //     score: score ?? this.score,
  //     outOfScore: outOfScore ?? this.outOfScore,
  //     batchId: batchId ?? this.batchId,
  //     logActivity: logActivity ?? this.logActivity,
  //     studentId: studentId ?? this.studentId,
  //     inCorrectAnswer: inCorrectAnswer ?? this.inCorrectAnswer,
  //     bonus: bonus ?? this.bonus,
  //     testLogVo: testLogVo ?? this.testLogVo,
  //     partialCorrect: partialCorrect ?? this.partialCorrect,
  //     attemptedQuestions: attemptedQuestions ?? this.attemptedQuestions,
  //     createdOn: createdOn ?? this.createdOn,
  //     rank: rank ?? this.rank,
  //     syncStatus: syncStatus ?? this.syncStatus,
  //     resultShowHide: resultShowHide ?? this.resultShowHide,
  //     partialResult: partialResult ?? this.partialResult,
  //     autoSubmit: autoSubmit ?? this.autoSubmit,
  //     logActive: logActive ?? this.logActive,
  //     questionIds: questionIds ?? this.questionIds,
  //   );
  // }


  SubmitTestResponse copyWith({
    int? testId,
    List<QuestionMobileVos>? questions,
    List<QuestionResult>? questionResult,
    int? totalQuestions,
    int? correctAnswers,
    int? unAttemptedQuestions,
    double? score,
    double? outOfScore,
    int? batchId,
    Null? logActivity,
    int? studentId,
    int? inCorrectAnswer,
    double? bonus,
    Null? testLogVo,
    int? partialCorrect,
    int? attemptedQuestions,
    int? createdOn,
    int? rank,
    int? syncStatus,
    bool? resultShowHide,
    bool? partialResult,
    bool? autoSubmit,
    bool? logActive,
    List<int>? questionIds,
  }) {
    return SubmitTestResponse(
      testId: testId ?? this.testId,
      questions: questions ?? this.questions,
      questionResult: questionResult ?? this.questionResult,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      unAttemptedQuestions: unAttemptedQuestions ?? this.unAttemptedQuestions,
      score: score ?? this.score,
      outOfScore: outOfScore ?? this.outOfScore,
      batchId: batchId ?? this.batchId,
      logActivity: logActivity ?? this.logActivity,
      studentId: studentId ?? this.studentId,
      inCorrectAnswer: inCorrectAnswer ?? this.inCorrectAnswer,
      bonus: bonus ?? this.bonus,
      testLogVo: testLogVo ?? this.testLogVo,
      partialCorrect: partialCorrect ?? this.partialCorrect,
      attemptedQuestions: attemptedQuestions ?? this.attemptedQuestions,
      createdOn: createdOn ?? this.createdOn,
      rank: rank ?? this.rank,
      syncStatus: syncStatus ?? this.syncStatus,
      resultShowHide: resultShowHide ?? this.resultShowHide,
      partialResult: partialResult ?? this.partialResult,
      autoSubmit: autoSubmit ?? this.autoSubmit,
      logActive: logActive ?? this.logActive,
      questionIds: questionIds ?? this.questionIds,
    );
  }
}

class QuestionResult {
  int? id;
  int? questionId;
  List<bool>? userGivenAnswers;
  int? timeTaken;
  int? status;
  String? userSelectedOption;
  int? studentId;
  int? batchId;
  int? syncStatus;
  int? testId;
  int? answerStatus;
  int? userCorrectAnwserLength;

  QuestionResult(
      {this.id,
      this.questionId,
      this.userGivenAnswers,
      this.timeTaken,
      this.status,
      this.userSelectedOption,
      this.studentId,
      this.batchId,
      this.syncStatus,
      this.testId,
      this.answerStatus,
      this.userCorrectAnwserLength});

  QuestionResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['questionId'];
    // ignore: prefer_null_aware_operators
    userGivenAnswers = json['userGivenAnswers'] == null
        ? null
        : json['userGivenAnswers'].cast<bool>();
    timeTaken = json['timeTaken'];
    status = json['status'];
    userSelectedOption = json['userSelectedOption'];
    studentId = json['studentId'];
    batchId = json['batchId'];
    syncStatus = json['syncStatus'];
    testId = json['testId'];
    answerStatus = json['answerStatus'];
    userCorrectAnwserLength = json['userCorrectAnwserLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['questionId'] = questionId;
    data['userGivenAnswers'] = userGivenAnswers;
    data['timeTaken'] = timeTaken;
    data['status'] = status;
    data['userSelectedOption'] = userSelectedOption;
    data['studentId'] = studentId;
    data['batchId'] = batchId;
    data['syncStatus'] = syncStatus;
    data['testId'] = testId;
    data['answerStatus'] = answerStatus;
    data['userCorrectAnwserLength'] = userCorrectAnwserLength;
    return data;
  }
}
