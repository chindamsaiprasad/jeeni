import 'package:collection/collection.dart';
import 'package:jeeni/enums/question_type.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/response_models/submit_test_response.dart';

class ResultUtil {
  ResultUtil._privateConstructor();

  static final ResultUtil _instance = ResultUtil._privateConstructor();

  factory ResultUtil() {
    return _instance;
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

  int getStatusForColoum(
    String? userSelectedOption,
    List<String>? columnMatchAnswer,
  ) {
    if (userSelectedOption == null) {
      return 2;
    }

    List<String> separatedValues = userSelectedOption.split(',').toList();
    final nullCount =
        separatedValues.where((selected) => selected == "null").toList().length;

    if (nullCount == 4) {
      return 2;
    }

    if (nullCount == 0) {
      const listEquality = ListEquality();
      final isCorrect = listEquality.equals(
        separatedValues,
        columnMatchAnswer,
      );
      return isCorrect ? 1 : 0;
    }

    for (int index = 0; index < separatedValues.length; index++) {
      if (separatedValues[index] != "null") {
        if (separatedValues[index] != columnMatchAnswer![index]) {
          return 0;
        }
      }
    }
    return 3;
  }

  List<bool> convertTouserGivenAnswersForMultiple(String? userSelectedOption) {
    final userGivenAnswers = [false, false, false, false];
    if (userSelectedOption == null) return userGivenAnswers;

    List<String> separatedValues = userSelectedOption.split(',').toList();

    for (int index = 0; index < separatedValues.length; index++) {
      if (index == 0 && separatedValues[index] == "A") {
        userGivenAnswers[index] = true;
      }
      if (index == 1 && separatedValues[index] == "B") {
        userGivenAnswers[index] = true;
      }
      if (index == 2 && separatedValues[index] == "C") {
        userGivenAnswers[index] = true;
      }
      if (index == 3 && separatedValues[index] == "D") {
        userGivenAnswers[index] = true;
      }
    }
    return userGivenAnswers;
  }

  int getStatusForMultiple(List<bool> userGivenAnswers,
      List<bool>? multipleAnswer, String? userSelectedOption) {
    print("userGivenAnswers :: $userGivenAnswers");
    print("multipleAnswer :: $multipleAnswer");
    print("userSelectedOption :: $userSelectedOption");
    if (userSelectedOption == null) {
      return 2;
    }

    if (multipleAnswer == null) {
      return 2;
    }

    final userGivenTrueCount = userGivenAnswers
        .where((isAnswered) => isAnswered == true)
        .toList()
        .length;

    final actulaAnswerTrueCoun = multipleAnswer
        .where((isAnswered) => isAnswered == true)
        .toList()
        .length;

    if (userGivenTrueCount == actulaAnswerTrueCoun) {
      const listEquality = ListEquality();
      final isCorrect = listEquality.equals(
        userGivenAnswers,
        multipleAnswer,
      );
      return isCorrect ? 1 : 0;
    } else if (userGivenTrueCount < actulaAnswerTrueCoun) {
      for (int index = 0; index < userGivenAnswers.length; index++) {
        if (userGivenAnswers[index]) {
          if (userGivenAnswers[index] != multipleAnswer[index]) {
            return 0;
          }
        }
      }

      return 3;
    } else {
      return 0;
    }
  }

  List<Result> convertToResult(SubmitTestResponse submitTestResponse) {
    final questions = submitTestResponse.questions ?? [];
    final testId = submitTestResponse.testId;
    if (questions.isNotEmpty) {
      final userSolutions = submitTestResponse.questionResult ?? [];
      if (userSolutions.isNotEmpty) {
        return questions.map((question) {
          final userSolution =
              findUserSolutionById(question.id!, userSolutions);

          switch (question.questionType ?? "") {
            case QuestionType.BASIC:
            case QuestionType.COMPREHENSION:
            case QuestionType.MATRIX:
            case QuestionType.ASSERTION_AND_REASON:
              if (question.isMultipleAnswer ?? false) {
                final userGivenAnswers = convertTouserGivenAnswersForMultiple(
                    question.userSelectedOption);
                return Result(
                  testId: testId!,
                  section: question.section ?? "",
                  questionId: question.id!,
                  status: Status.getStatus(getStatusForMultiple(
                      userGivenAnswers,
                      question.answerValidity,
                      question.userSelectedOption)),
                  questionUrl: question.questionUrl ?? "",
                  solutionUrl: question.solutionUrl ?? "",
                  timeTaken: 0,
                  negativeMark: question.negativeMark ?? 0,
                  positiveMark: question.positiveMark ?? 0,
                  isMultipleAnswer: question.isMultipleAnswer ?? false,
                  userSelectedOption: question.userSelectedOption,
                  actualAnswer: null,
                  numericAnswer: null,
                  userGivenAnswers: userGivenAnswers,
                  questionType: question.questionType ?? "",
                  answerValidity: question.answerValidity ?? [],
                  columnMatchAnswer: question.columnMatchAnswer ??
                      ["null", "null", "null", "null"],
                );
              }
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
                columnMatchAnswer:
                    question.columnMatchAnswer ?? ["", "", "", ""],
              );

            case QuestionType.COLUMN_MATCHING:
              return Result(
                testId: testId!,
                section: question.section ?? "",
                questionId: question.id!,
                status: Status.getStatus(
                  getStatusForColoum(
                      question.userSelectedOption, question.columnMatchAnswer),
                ),
                questionUrl: question.questionUrl ?? "",
                solutionUrl: question.solutionUrl ?? "",
                timeTaken: 0,
                negativeMark: question.negativeMark ?? 0,
                positiveMark: question.positiveMark ?? 0,
                isMultipleAnswer: question.isMultipleAnswer ?? false,
                userSelectedOption: question.userSelectedOption,
                actualAnswer: null,
                numericAnswer: null,
                userGivenAnswers: [false, false, false, false],
                questionType: question.questionType ?? "",
                answerValidity: question.answerValidity ?? [],
                columnMatchAnswer:
                    question.columnMatchAnswer ?? ["", "", "", ""],
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
                columnMatchAnswer:
                    question.columnMatchAnswer ?? ["", "", "", ""],
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
                  columnMatchAnswer:
                      question.columnMatchAnswer ?? ["", "", "", ""]);

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
                  columnMatchAnswer:
                      question.columnMatchAnswer ?? ["", "", "", ""]);
          }
        }).toList();
      }
    }
    return [];
  }
}
