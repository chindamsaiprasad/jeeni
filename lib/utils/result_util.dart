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
