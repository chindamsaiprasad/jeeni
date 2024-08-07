// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/response_models/view_solution.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jeeni/enums/question_type.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/response_models/submit_test_response.dart';

class Solution with ChangeNotifier {}

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
        return const Color.fromARGB(255, 228, 53, 40);

      case Status.UNATTEMPTED:
        return Colors.grey.shade400;
      case Status.PARTIAL_CORRECT:
        return const Color(0xfff0ad4e);
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
  final List<String> columnMatchAnswer;

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
    required this.columnMatchAnswer,
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
    List<String>? columnMatchAnswer,
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
        columnMatchAnswer: columnMatchAnswer ?? this.columnMatchAnswer);
  }

  @override
  String toString() {
    return 'Result(testId: $testId, section: $section, questionId: $questionId, status: $status, questionUrl: $questionUrl, solutionUrl: $solutionUrl, timeTaken: $timeTaken, positiveMark: $positiveMark, negativeMark: $negativeMark, isMultipleAnswer: $isMultipleAnswer, userSelectedOption: $userSelectedOption, actualAnswer: $actualAnswer, numericAnswer: $numericAnswer, userGivenAnswers: $userGivenAnswers, answerValidity: $answerValidity, questionType: $questionType)';
  }

  getUserSelecetdOption() {
    print("getUserSelecetdOption");
    print(userGivenAnswers);
  }
}

// class SolutionProvider with ChangeNotifier {
//   final SubmitTestResponse submitTestResponse;
//   // late ViewSolution viewSolution;
//   final Ref ref;
//   List<QuestionMobileVos> _questions = [];
//   // Map<int, QuestionResult> userSolutions = {};

//   List<Result> _solution = [];

//   Result? _currentQuestion;

//   SolutionProvider({
//     required this.submitTestResponse,
//     required this.ref,
//   }) {
//     _questions = submitTestResponse.questions ?? [];
//     final testId = submitTestResponse.testId;
//     if (_questions.isNotEmpty) {
//       final userSolutions = submitTestResponse.questionResult ?? [];
//       if (userSolutions.isNotEmpty) {
//         _solution = _questions.map((question) {
//           final userSolution =
//               findUserSolutionById(question.id!, userSolutions);

//           switch (question.questionType ?? "") {
//             case QuestionType.BASIC:
//             case QuestionType.COLUMN_MATCHING:
//             case QuestionType.COMPREHENSION:
//             case QuestionType.MATRIX:
//             case QuestionType.ASSERTION_AND_REASON:
//               return Result(
//                   testId: testId!,
//                   section: question.section ?? "",
//                   questionId: question.id!,
//                   status: Status.getStatus(userSolution?.status),
//                   questionUrl: question.questionUrl ?? "",
//                   solutionUrl: question.solutionUrl ?? "",
//                   timeTaken: userSolution?.timeTaken ?? 0,
//                   negativeMark: question.negativeMark ?? 0,
//                   positiveMark: question.positiveMark ?? 0,
//                   isMultipleAnswer: question.isMultipleAnswer ?? false,
//                   userSelectedOption: userSolution?.userSelectedOption,
//                   actualAnswer: null,
//                   numericAnswer: null,
//                   userGivenAnswers: userSolution?.userGivenAnswers ??
//                       [false, false, false, false],
//                   questionType: question.questionType ?? "",
//                   answerValidity: question.answerValidity ?? [],
//                   columnMatchAnswer:
//                       question.columnMatchAnswer ?? ["", "", "", ""]);

//             case QuestionType.NUMERIC:
//               return Result(
//                   testId: testId!,
//                   section: question.section ?? "",
//                   questionId: question.id!,
//                   status: Status.getStatus(userSolution?.status),
//                   questionUrl: question.questionUrl ?? "",
//                   solutionUrl: question.solutionUrl ?? "",
//                   timeTaken: userSolution?.timeTaken ?? 0,
//                   negativeMark: question.negativeMark ?? 0,
//                   positiveMark: question.positiveMark ?? 0,
//                   isMultipleAnswer: question.isMultipleAnswer ?? false,
//                   userSelectedOption: userSolution?.userSelectedOption,
//                   actualAnswer: question.numericAnswer,
//                   numericAnswer: null,
//                   userGivenAnswers: userSolution?.userGivenAnswers ??
//                       [false, false, false, false],
//                   questionType: question.questionType ?? "",
//                   answerValidity: question.answerValidity ?? [],
//                   columnMatchAnswer:
//                       question.columnMatchAnswer ?? ["", "", "", ""]);
//             case QuestionType.INTEGER:
//               return Result(
//                   testId: testId!,
//                   section: question.section ?? "",
//                   questionId: question.id!,
//                   status: Status.getStatus(userSolution?.status),
//                   questionUrl: question.questionUrl ?? "",
//                   solutionUrl: question.solutionUrl ?? "",
//                   timeTaken: userSolution?.timeTaken ?? 0,
//                   negativeMark: question.negativeMark ?? 0,
//                   positiveMark: question.positiveMark ?? 0,
//                   isMultipleAnswer: question.isMultipleAnswer ?? false,
//                   userSelectedOption: userSolution?.userSelectedOption,
//                   actualAnswer: null,
//                   numericAnswer: null,
//                   userGivenAnswers: userSolution?.userGivenAnswers ??
//                       [false, false, false, false],
//                   questionType: question.questionType ?? "",
//                   answerValidity: question.answerValidity ?? [],
//                   columnMatchAnswer:
//                       question.columnMatchAnswer ?? ["", "", "", ""]);

//             default:
//               return Result(
//                   testId: testId!,
//                   section: question.section ?? "",
//                   questionId: question.id!,
//                   status: Status.getStatus(userSolution?.status),
//                   questionUrl: question.questionUrl ?? "",
//                   solutionUrl: question.solutionUrl ?? "",
//                   timeTaken: userSolution?.timeTaken ?? 0,
//                   negativeMark: question.negativeMark ?? 0,
//                   positiveMark: question.positiveMark ?? 0,
//                   isMultipleAnswer: question.isMultipleAnswer ?? false,
//                   userSelectedOption: userSolution?.userSelectedOption,
//                   actualAnswer: null,
//                   numericAnswer: null,
//                   userGivenAnswers: userSolution?.userGivenAnswers ??
//                       [false, false, false, false],
//                   questionType: question.questionType ?? "NA",
//                   answerValidity: question.answerValidity ?? [],
//                   columnMatchAnswer:
//                       question.columnMatchAnswer ?? ["", "", "", ""]);
//           }
//         }).toList();
//       }
//       _currentQuestion = _solution.first;
//     }
//   }

//   Result? get currentQuestion => _currentQuestion;

//   List<Result> get getQuestion => _solution;

//   Result? get getCurrentQuestion => _currentQuestion;

//   int get getQuestionCount => _solution.length;

//   void updateCurrentQuestion(int questionId) {
//     // final currentQuestion = getCurrentQuestion;
//     if (questionId == 0) return;

//     final tempList = [..._solution];
//     var index =
//         tempList.indexWhere((question) => question.questionId == questionId);
//     _currentQuestion = tempList.elementAt(index).copyWith();
//     // _reset();
//     notifyListeners();
//   }

//   void next() {
//     final currentQuestion = getCurrentQuestion;
//     if (currentQuestion == null) return;
//     final tempList = [..._solution];
//     var index = tempList.indexWhere(
//         (question) => question.questionId == currentQuestion.questionId);

//     index = index + 1;
//     if ((index) < tempList.length) {
//       _currentQuestion = tempList.elementAt(index).copyWith();
//     } else {
//       _currentQuestion = tempList.first.copyWith();
//     }
//     notifyListeners();
//   }

//   int currentQuestionIndex() {
//     final currentQuestion = getCurrentQuestion;
//     if (currentQuestion == null) return -1;
//     return [..._solution].indexWhere(
//         (question) => question.questionId == currentQuestion.questionId);
//   }

//   void previous() {
//     final currentQuestion = getCurrentQuestion;
//     if (currentQuestion == null) return;

//     final tempList = [..._solution];
//     var index = tempList.indexWhere(
//         (question) => question.questionId == currentQuestion.questionId);

//     index = index - 1;
//     if ((index) >= 0) {
//       _currentQuestion = tempList.elementAt(index).copyWith();
//     } else {
//       _currentQuestion = tempList.last.copyWith();
//     }
//     notifyListeners();
//   }

//   bool showSolutionImage = false;
//   void solutionImage() {
//     showSolutionImage = !showSolutionImage;
//     notifyListeners();
//   }

//   QuestionResult? findUserSolutionById(
//       int questionId, List<QuestionResult> userSolutions) {
//     for (var solution in userSolutions) {
//       if (solution.questionId == questionId) {
//         return solution;
//       }
//     }
//     return null;
//   }

//   getUserGivenColoumAnswer() {
//     if (_currentQuestion == null) return ["", "", "", ""];
//     return _currentQuestion!.userSelectedOption == null
//         ? ["", "", "", ""]
//         : _currentQuestion!.userSelectedOption!.split(',');
//   }

//   String getActualAnswer() {
//     if (_currentQuestion == null) return "";
//     //Answers :-> A:p, B:p, C:q, D:r
//     final columnMatchAnswer = _currentQuestion!.columnMatchAnswer;
//     if (columnMatchAnswer.length == 4) {
//       return "Answers :-> A:${columnMatchAnswer[0]}, B:${columnMatchAnswer[1]}, C:${columnMatchAnswer[2]}, D:${columnMatchAnswer[3]}";
//     }
//     return "";
//   }
// }

class SolutionProvider with ChangeNotifier {
  final Ref ref;
  final List<Result> solution;
  Result currentQuestion;

  SolutionProvider({
    required this.solution,
    required this.ref,
    required this.currentQuestion,
  });

  // Result get currentQuestion => currentQuestion;

  List<Result> get getQuestion => solution;

  Result? get getCurrentQuestion => currentQuestion;

  int get getQuestionCount => solution.length;

  void updateCurrentQuestion(int questionId) {
    if (questionId == 0) return;

    final tempList = [...solution];
    var index =
        tempList.indexWhere((question) => question.questionId == questionId);
    currentQuestion = tempList.elementAt(index).copyWith();
    // _reset();
    notifyListeners();
  }

  void next() {
    // final currentQuestion = getCurrentQuestion;
    // if (currentQuestion == null) return;
    final tempList = [...solution];
    var index = tempList.indexWhere(
        (question) => question.questionId == currentQuestion.questionId);

    index = index + 1;
    if ((index) < tempList.length) {
      currentQuestion = tempList.elementAt(index).copyWith();
    } else {
      currentQuestion = tempList.first.copyWith();
    }
    notifyListeners();
  }

  int currentQuestionIndex() {
    final currentQuestion = getCurrentQuestion;
    if (currentQuestion == null) return -1;
    return [...solution].indexWhere(
        (question) => question.questionId == currentQuestion.questionId);
  }

  void previous() {
    // final currentQuestion = getCurrentQuestion;
    // if (currentQuestion == null) return;

    final tempList = [...solution];
    var index = tempList.indexWhere(
        (question) => question.questionId == currentQuestion.questionId);

    index = index - 1;
    if ((index) >= 0) {
      currentQuestion = tempList.elementAt(index).copyWith();
    } else {
      currentQuestion = tempList.last.copyWith();
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

  List<String> getUserGivenColoumAnswer() {
    // if (_currentQuestion == null) return ["", "", "", ""];
    return currentQuestion!.userSelectedOption == null
        ? ["", "", "", ""]
        : currentQuestion!.userSelectedOption!.split(',');
  }

  String getActualAnswer() {
    // if (_currentQuestion == null) return "";
    //Answers :-> A:p, B:p, C:q, D:r
    final columnMatchAnswer = currentQuestion!.columnMatchAnswer;
    if (columnMatchAnswer.length == 4) {
      return "Answers :-> A:${columnMatchAnswer[0]}, B:${columnMatchAnswer[1]}, C:${columnMatchAnswer[2]}, D:${columnMatchAnswer[3]}";
    }
    return "";
  }

  List<bool> getUserSelecetdOption() {
    final userGivenAnswer = [false, false, false, false];

    List<String> userSelectedOptions = getUserGivenColoumAnswer();

    for (int index = 0; index < userSelectedOptions.length; index++) {
      if (index == 0) {
        if (userSelectedOptions[index] == "A") {
          userGivenAnswer[index] = true;
        }
      } else if (index == 1) {
        if (userSelectedOptions[index] == "B") {
          userGivenAnswer[index] = true;
        }
      } else if (index == 2) {
        if (userSelectedOptions[index] == "C") {
          userGivenAnswer[index] = true;
        }
      } else if (index == 3) {
        if (userSelectedOptions[index] == "D") {
          userGivenAnswer[index] = true;
        }
      }
    }
    return userGivenAnswer;
  }
}
