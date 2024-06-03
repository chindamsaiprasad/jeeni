// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jeeni/enums/question_type.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/response_models/submit_test_response.dart';

enum Status {
  INCORRECT_ANSWER,
  CORRECT_ANSWER,
  UNATTEMPTED,
  PARTIAL_CORRECT,
  INVALID;

  static Status getStatus(int? status) {
    if (status == null) return Status.INVALID;

    switch (status) {
      case 0:
        return Status.INCORRECT_ANSWER;
      case 1:
        return Status.CORRECT_ANSWER;
      case 2:
        return Status.UNATTEMPTED;
      case 3:
        return Status.PARTIAL_CORRECT;
      default:
        return Status.INVALID;
    }
  }

  Color getColor() {
    switch (this) {
      case Status.CORRECT_ANSWER:
        return Colors.green;
      case Status.INCORRECT_ANSWER:
        return Colors.red.shade400;

      case Status.UNATTEMPTED:
        return Colors.grey.shade400;
      case Status.PARTIAL_CORRECT:
      default:
        return Colors.grey.shade400;
      // return Colors.grey[600];
    }
  }
}

class Result {
  final int testId;
  final String section;
  final int questionId;
  final Status status;
  final String questionUrl;
  final String solutionUrl;
  final int timeTaken;
  double positiveMark;
  double negativeMark;
  final bool isMultipleAnswer;
  String? userSelectedOption;
  String? actualAnswer;
  String? numericAnswer;
  final List<bool> userGivenAnswers;
  final List<bool> answerValidity;
  final String questionType;

  Result({
    required this.testId,
    required this.section,
    required this.questionId,
    required this.status,
    required this.questionUrl,
    required this.solutionUrl,
    required this.timeTaken,
    required this.negativeMark,
    required this.positiveMark,
    required this.isMultipleAnswer,
    required this.userSelectedOption,
    required this.actualAnswer,
    required this.numericAnswer,
    required this.userGivenAnswers,
    required this.questionType,
    required this.answerValidity,
  });

  Result copyWith({
    int? testId,
    String? section,
    int? questionId,
    Status? status,
    String? questionUrl,
    String? solutionUrl,
    int? timeTaken,
    double? positiveMark,
    double? negativeMark,
    bool? isMultipleAnswer,
    String? userSelectedOption,
    String? actualAnswer,
    String? numericAnswer,
    List<bool>? userGivenAnswers,
    List<bool>? answerValidity,
    String? questionType,
  }) {
    return Result(
      testId: testId ?? this.testId,
      section: section ?? this.section,
      questionId: questionId ?? this.questionId,
      status: status ?? this.status,
      questionUrl: questionUrl ?? this.questionUrl,
      solutionUrl: solutionUrl ?? this.solutionUrl,
      timeTaken: timeTaken ?? this.timeTaken,
      positiveMark: positiveMark ?? this.positiveMark,
      negativeMark: negativeMark ?? this.negativeMark,
      isMultipleAnswer: isMultipleAnswer ?? this.isMultipleAnswer,
      userSelectedOption: userSelectedOption ?? this.userSelectedOption,
      actualAnswer: actualAnswer ?? this.actualAnswer,
      numericAnswer: numericAnswer ?? this.numericAnswer,
      userGivenAnswers: userGivenAnswers ?? this.userGivenAnswers,
      answerValidity: answerValidity ?? this.answerValidity,
      questionType: questionType ?? this.questionType,
    );
  }
}

class SolutionProvider with ChangeNotifier {
  final SubmitTestResponse submitTestResponse;

  List<QuestionMobileVos> _questions = [];
  Map<int, QuestionResult> userSolutions = {};

  List<Result> _solution = [];

  Result? _currentQuestion;

  final Ref ref;
  SolutionProvider({
    required this.submitTestResponse,
    required this.ref,
  }) {
    print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    _questions = submitTestResponse.questions ?? [];

    _questions = submitTestResponse.questions ?? [];
    final testId = submitTestResponse.testId;
    if (_questions.isNotEmpty) {
      final userSolutions = submitTestResponse.questionResult ?? [];
      if (userSolutions.isNotEmpty) {
        _solution = _questions.map((question) {
          final userSolution =
              findUserSolutionById(question.id!, userSolutions);

          switch (question.questionType ?? "") {
            case QuestionType.BASIC:
            case QuestionType.COLUMN_MATCHING:
            case QuestionType.COMPREHENSION:
            case QuestionType.MATRIX:
            case QuestionType.ASSERTION_AND_REASON:
              return Result(
                testId: testId!,
                section: question.section ?? "",
                questionId: question.id!,
                status: Status.getStatus(userSolution?.status),
                questionUrl: question.questionUrl ?? "",
                solutionUrl: question.solutionUrl ?? "",
                timeTaken: userSolution?.timeTaken ?? 0,
                negativeMark: question.negativeMark ?? 0,
                positiveMark: question.positiveMark ?? 0,
                isMultipleAnswer: question.isMultipleAnswer ?? false,
                userSelectedOption: userSolution?.userSelectedOption,
                actualAnswer: null,
                numericAnswer: null,
                userGivenAnswers: userSolution?.userGivenAnswers ??
                    [false, false, false, false],
                questionType: question.questionType ?? "",
                answerValidity: question.answerValidity ?? [],
              );

            case QuestionType.NUMERIC:
              return Result(
                testId: testId!,
                section: question.section ?? "",
                questionId: question.id!,
                status: Status.getStatus(userSolution?.status),
                questionUrl: question.questionUrl ?? "",
                solutionUrl: question.solutionUrl ?? "",
                timeTaken: userSolution?.timeTaken ?? 0,
                negativeMark: question.negativeMark ?? 0,
                positiveMark: question.positiveMark ?? 0,
                isMultipleAnswer: question.isMultipleAnswer ?? false,
                userSelectedOption: userSolution?.userSelectedOption,
                actualAnswer: question.numericAnswer,
                numericAnswer: null,
                userGivenAnswers: userSolution?.userGivenAnswers ??
                    [false, false, false, false],
                questionType: question.questionType ?? "",
                answerValidity: question.answerValidity ?? [],
              );
            case QuestionType.INTEGER:
              return Result(
                testId: testId!,
                section: question.section ?? "",
                questionId: question.id!,
                status: Status.getStatus(userSolution?.status),
                questionUrl: question.questionUrl ?? "",
                solutionUrl: question.solutionUrl ?? "",
                timeTaken: userSolution?.timeTaken ?? 0,
                negativeMark: question.negativeMark ?? 0,
                positiveMark: question.positiveMark ?? 0,
                isMultipleAnswer: question.isMultipleAnswer ?? false,
                userSelectedOption: userSolution?.userSelectedOption,
                actualAnswer: null,
                numericAnswer: null,
                userGivenAnswers: userSolution?.userGivenAnswers ??
                    [false, false, false, false],
                questionType: question.questionType ?? "",
                answerValidity: question.answerValidity ?? [],
              );

            default:
              return Result(
                testId: testId!,
                section: question.section ?? "",
                questionId: question.id!,
                status: Status.getStatus(userSolution?.status),
                questionUrl: question.questionUrl ?? "",
                solutionUrl: question.solutionUrl ?? "",
                timeTaken: userSolution?.timeTaken ?? 0,
                negativeMark: question.negativeMark ?? 0,
                positiveMark: question.positiveMark ?? 0,
                isMultipleAnswer: question.isMultipleAnswer ?? false,
                userSelectedOption: userSolution?.userSelectedOption,
                actualAnswer: null,
                numericAnswer: null,
                userGivenAnswers: userSolution?.userGivenAnswers ??
                    [false, false, false, false],
                questionType: question.questionType ?? "NA",
                answerValidity: question.answerValidity ?? [],
              );
          }
        }).toList();
      }
      _currentQuestion = _solution.first;
    }
  }

  Result? get currentQuestion => _currentQuestion;

  List<Result> get getQuestion => _solution;

  Result? get getCurrentQuestion => _currentQuestion;

  int get getQuestionCount => _solution.length;

  // Future<void> _storeLocally(SubmitTestResponse submitTestResponse) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String userJson = submitTestResponse.toJson().toString();
  //   await prefs.setString("submitTestResponse", userJson);
  //   print(prefs.getString("submitTestResponse"));
  //   print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
  // }

  // Future<void> _load() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? userJson = prefs.getString("submitTestResponse");
  //   if (userJson != null) {
  //     Map<String, dynamic> userMap =
  //         Map<String, dynamic>.from(jsonDecode(userJson));
  //     final submitTestResponse = SubmitTestResponse.fromJson(userMap);

  //     _questions = submitTestResponse.questions ?? [];
  //     if (_questions.isNotEmpty) {
  //       _currentQuestion = _questions.first;

  //       userSolutions = Map.fromEntries(
  //         (submitTestResponse.questionResult ?? []).map(
  //           (userSolution) => MapEntry(userSolution.questionId!, userSolution),
  //         ),
  //       );
  //     }
  //   }
  // }

  void next() {
    final currentQuestion = getCurrentQuestion;
    if (currentQuestion == null) return;
    final tempList = [..._solution];
    var index = tempList.indexWhere(
        (question) => question.questionId == currentQuestion.questionId);

    index = index + 1;
    if ((index) < tempList.length) {
      _currentQuestion = tempList.elementAt(index).copyWith();
    } else {
      _currentQuestion = tempList.first.copyWith();
    }
    notifyListeners();
  }

  int currentQuestionIndex() {
    final currentQuestion = getCurrentQuestion;
    if (currentQuestion == null) return -1;
    return [..._solution].indexWhere(
        (question) => question.questionId == currentQuestion.questionId);
  }

  void previous() {
    final currentQuestion = getCurrentQuestion;
    if (currentQuestion == null) return;

    final tempList = [..._solution];
    var index = tempList.indexWhere(
        (question) => question.questionId == currentQuestion.questionId);

    index = index - 1;
    if ((index) >= 0) {
      _currentQuestion = tempList.elementAt(index).copyWith();
    } else {
      _currentQuestion = tempList.last.copyWith();
    }
    notifyListeners();
  }

  bool showSolutionImage = false;
  void solutionImage() {
    showSolutionImage = !showSolutionImage;
    notifyListeners();
  }

  QuestionResult? findUserSolutionById(
      int questionId, List<QuestionResult> userSolutions) {
    for (var solution in userSolutions) {
      if (solution.questionId == questionId) {
        return solution;
      }
    }
    return null;
  }
}
