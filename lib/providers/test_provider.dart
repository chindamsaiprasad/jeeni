import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/enums/question_type.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/response_models/submit_test_response.dart';
import 'package:jeeni/response_models/test_response.dart';
import 'package:jeeni/response_models/test_soultion.dart';
import 'package:jeeni/response_models/view_solution.dart';
import 'package:jeeni/utils/file_utils.dart';

final testProvider = ChangeNotifierProvider((ref) => TestProvider(ref: ref));

class TestProvider with ChangeNotifier {
  Iterable<Test> tests = [];

  List<QuestionMobileVosTwo> questions = [];

  final Ref ref;
  TestProvider({
    required this.ref,
  });

  Future<http.Response> fetchAllTestsFromJeeniServer() async {
    final response = await ref.read(networkProvider).networkHandlerMethod(
        url: "$BASE_URL/mtest/getByStudentId", httpMethodType: RequestType.get);

    print("RESPONSE STATUS CODE:: ${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body) as List;
      tests = responseData.map((test) => Test.fromJson(test));
      print("LENGTH ${this.tests.length}");
    }
    return response;
  }

  saveAndroidActivity() {
    // POST

    // url :: https://exam.jeeni.in/Jeeni/rest/mtest/saveAndroidActivity?activities=Time%3A%2003-05-2024%2004%3A28%3A04%20PM%2C%20Student%20Login%20Id%3A%20joshi_352%2C%20QuestionId%3A%20%2C%20Action%20Performed%3A%20Test%20Download%20&testId=218185
  }

  getQuestion() {
    //https://exam.jeeni.in/Jeeni/rest/mtest/getQuestionImageByMockTestAndQuestionIdforMobile/218185/1080/2016?questionId=14770&questionId=14771&questionId=14773&questionId=14774&questionId=14775

    // gzip
  }

  Future<TestDownloadResponse> pretestDownload({
    required int testId,
    required double deviceWidth,
    required double deviceHeight,
  }) async {
    final jauth = ref.read(authenticationProvider)?.jauth;

    Map<String, String> headers = {};
    headers.addAll({"Content-Type": "application/json", "Jauth": jauth!});

    return await http
        .get(Uri.parse("$BASE_URL/mtest/pretestdownload/$testId/1080/2016"),
            headers: headers)
        .then((response) async {
      Map<String, dynamic> data = json.decode(response.body);

      print("test download $data");
      return TestDownloadResponse.fromJson(data);
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      throw Exception(error);
    });
  }

  Future<SubmitTestResponse> submitTest(
      {required TestResultRequest testResultRequest}) {
    final jauth = ref.read(authenticationProvider)?.jauth;

    Map<String, String> headers = {};

    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
      "Jauth": jauth!
    });

    const url = "https://exam.jeeni.in/Jeeni/rest/mtest/submitResult";

    final body = {
      'correctAnswers': testResultRequest.correctAnswers,
      // 'isAutoSubmit': testResultRequest.isAutoSubmit,
      // 'isLogActive': testResultRequest.isLogActive,
      "questionResult": testResultRequest.questionResult != null
          ? testResultRequest.questionResult!
              .map(
                (e) => {
                  "questionId": e.questionId,
                  "status": e.status,
                  "timeTaken": e.timeTaken,
                  "userGivenAnswers": e.userGivenAnswers,
                  "userSelectedOption": e.userSelectedOption
                },
              )
              .toList()
          : [],
      'testId': testResultRequest.testId,
      'unAttemptedQuestions': testResultRequest.unAttemptedQuestions,
    };

    String jsonString = jsonEncode(body);
    return http.post(Uri.parse(url),
        headers: headers, body: {"testResult": jsonString}).then((response) {
      print("jsonString 11 RESPONSE 11 :: ${response.body}");

      print("jsonString 11 :: ${jsonString}");

      if (response.statusCode != 200) {
        throw Exception("${response.statusCode}  ${response.body}");
      }

      Map<String, dynamic> data = json.decode(response.body);
      final submitTestResponse = SubmitTestResponse.fromJson(data);
      removeTestLocally(submitTestResponse.testId);
      return submitTestResponse;
    }).catchError((error) {
      print("ERROR :: $error");
    });
  }

  Map<int, String?> solutions = {};

  Future<void> fetchQuestionSolution(List<int> questionIds, int testId) async {
    for (var id in questionIds) {
      solutions[id] = null;
    }

    final id = questionIds.first;
    final jauth = ref.read(authenticationProvider)?.jauth;

    Map<String, String> headers = {};

    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/json",
      "Jauth": jauth!
    });
    await http
        .get(
            Uri.parse(
                "$BASE_URL/mtest/getQuestionImageByMockTestAndQuestionId/$id/$testId/1080/2180"),
            headers: headers)
        .then((response) {
      print("RESPONSE SOLUTION:: ${response.body}");
      print("RESPONSE SOLUTION:: ${response.statusCode}");
      // var responseData = json.decode(response.body) as List;

      // tests = responseData.map((test) => Test.fromJson(test));
      print("LENGTH ${this.tests.length}");
      // return true;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: FETCH TEST");
      throw Exception(error);
    });
  }

  void removeTestLocally(int? testId) {
    if (testId == null) return;

    tests = tests.where((test) => test.id != testId);
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////
  List<bool> convertTouserGivenAnswers(String? userSelectedOption) {
    final userGivenAnswers = [false, false, false, false];
    if (userSelectedOption == null) return userGivenAnswers;

    if (userSelectedOption == "A") {
      userGivenAnswers[0] = true;
    }
    if (userSelectedOption == "B") {
      userGivenAnswers[1] = true;
    }
    if (userSelectedOption == "C") {
      userGivenAnswers[2] = true;
    }
    if (userSelectedOption == "D") {
      userGivenAnswers[3] = true;
    }
    return userGivenAnswers;
  }

  int getStatus(String? userSelectedOption, List<bool>? answerValidity) {
    if (userSelectedOption == null) return 2;
    final tempAnswerValidity = answerValidity ?? [false, false, false, false];
    if (userSelectedOption == "A") {
      return tempAnswerValidity[0] == true ? 1 : 0;
    }
    if (userSelectedOption == "B") {
      return tempAnswerValidity[1] == true ? 1 : 0;
    }
    if (userSelectedOption == "C") {
      return tempAnswerValidity[2] == true ? 1 : 0;
    }
    if (userSelectedOption == "D") {
      return tempAnswerValidity[3] == true ? 1 : 0;
    }
    return 0;
  }

  int getStatusForInteger(
    List<bool> userGivenAnswers,
    List<bool>? answerValidity,
  ) {
    if (userGivenAnswers
        .where((selected) => selected == true)
        .toList()
        .isNotEmpty) {
      const listEquality = ListEquality();
      final isCorrect = listEquality.equals(
        answerValidity ?? [],
        userGivenAnswers,
      );
      return isCorrect ? 1 : 0;
    } else {
      return 2;
    }
  }

  List<bool> convertToUserGivenAnswersForInteger(String? userSelectedOption) {
    final userGivenAnswers = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];

    if (userSelectedOption == null) return userGivenAnswers;

    return List.generate(10, (index) => index.toString() == userSelectedOption);
  }

  List<String> convertToUserGivenAnswersForColoumMatching(
      String? userSelectedOption) {
    return [];
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
    // if (separatedValues
    //         .where((selected) => selected == "null")
    //         .toList()
    //         .length <
    //     4) {
    //   const listEquality = ListEquality();
    //   final isCorrect = listEquality.equals(
    //     separatedValues,
    //     columnMatchAnswer,
    //   );
    //   return isCorrect ? 1 : 0;
    // } else {
    //   return 2;
    // }
  }

  int getStatusForNumeric(
    String? userSelectedOption,
    String actualAnswer,
  ) {
    if (userSelectedOption == null) return 2;

    return userSelectedOption == actualAnswer ? 1 : 0;
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

  List<Result> convertToResult(ViewSolution solutionResponse) {
    final questions = solutionResponse.questionMobileVos ?? [];
    if (questions.isNotEmpty) {
      return questions.map((question) {
        switch (question.questionType ?? "") {
          case QuestionType.BASIC ||
                QuestionType.COMPREHENSION ||
                QuestionType.MATRIX:
            print("============111   ${question.toString()}=============");
            var userGivenAnswers =
                convertTouserGivenAnswers(question.userSelectedOption);

            if (question.isMultipleAnswer ?? false) {
              userGivenAnswers = convertTouserGivenAnswersForMultiple(
                  question.userSelectedOption);
              return Result(
                testId: solutionResponse.id ?? 0,
                section: question.section ?? "",
                questionId: question.id!,
                status: Status.getStatus(getStatusForMultiple(userGivenAnswers,
                    question.answerValidity, question.userSelectedOption)),
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
              testId: solutionResponse.id ?? 0,
              section: question.section ?? "",
              questionId: question.id!,
              status: Status.getStatus(getStatus(
                  question.userSelectedOption, question.answerValidity)),
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
              columnMatchAnswer: question.columnMatchAnswer ?? ["", "", "", ""],
            );

          case QuestionType.NUMERIC:
            print("============111   ${question.toString()}=============");
            return Result(
              testId: solutionResponse.id ?? 0,
              section: question.section ?? "",
              questionId: question.id!,
              status: Status.getStatus(getStatusForNumeric(
                  question.userSelectedOption, question.numericAnswer ?? "#")),
              questionUrl: question.questionUrl ?? "",
              solutionUrl: question.solutionUrl ?? "",
              timeTaken: 0,
              negativeMark: question.negativeMark ?? 0,
              positiveMark: question.positiveMark ?? 0,
              isMultipleAnswer: question.isMultipleAnswer ?? false,
              userSelectedOption: question.userSelectedOption,
              actualAnswer: question.numericAnswer,
              numericAnswer: question.numericAnswer,
              userGivenAnswers: [],
              questionType: question.questionType ?? "",
              answerValidity: question.answerValidity ?? [],
              columnMatchAnswer: question.columnMatchAnswer ?? ["", "", "", ""],
            );
          case QuestionType.INTEGER:
            print("============111   ${question.toString()}=============");
            final userGivenAnswers = convertToUserGivenAnswersForInteger(
              question.userSelectedOption,
            );
            return Result(
              testId: solutionResponse.id ?? 0,
              section: question.section ?? "",
              questionId: question.id!,
              status: Status.getStatus(
                getStatusForInteger(userGivenAnswers, question.answerValidity),
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
              userGivenAnswers: userGivenAnswers,
              questionType: question.questionType ?? "",
              answerValidity: question.answerValidity ?? [],
              columnMatchAnswer: question.columnMatchAnswer ?? ["", "", "", ""],
            );

          case QuestionType.COLUMN_MATCHING:
            print(
                "============111   ${question.userSelectedOption}============= ${question.columnMatchAnswer}  ${question.status}");

            return Result(
              testId: solutionResponse.id ?? 0,
              section: question.section ?? "",
              questionId: question.id!,
              // status: Status.getStatus(question.status),
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
              columnMatchAnswer: question.columnMatchAnswer ?? ["", "", "", ""],
            );
          default:
            if (question.questionType?.contains("ASSERTION") ?? false) {
              print(
                  "============DEFAULT  IF ${question.questionType}=============");

              final userGivenAnswers =
                  convertTouserGivenAnswers(question.userSelectedOption);
              print("${question.userSelectedOption}");
              print("$userGivenAnswers");
              return Result(
                testId: solutionResponse.id ?? 0,
                section: question.section ?? "",
                questionId: question.id!,
                status: Status.getStatus(getStatus(
                    question.userSelectedOption, question.answerValidity)),
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
                columnMatchAnswer:
                    question.columnMatchAnswer ?? ["", "", "", ""],
              );
            }
            print("============DEFAULT  ${question.questionType}=============");
            return Result(
              testId: solutionResponse.id ?? 0,
              section: question.section ?? "",
              questionId: question.id!,
              status: Status.getStatus(question.answerStatus),
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
              columnMatchAnswer: question.columnMatchAnswer ?? ["", "", "", ""],
            );
        }
      }).toList();
      //   final userSolutions = submitTestResponse.questionResult ?? [];
      //   if (userSolutions.isNotEmpty) {
      //     _solution = _questions.map((question) {
      //       final userSolution =
      //           findUserSolutionById(question.id!, userSolutions);

      //       switch (question.questionType ?? "") {
      //         case QuestionType.BASIC:
      //         case QuestionType.COLUMN_MATCHING:
      //         case QuestionType.COMPREHENSION:
      //         case QuestionType.MATRIX:
      //         case QuestionType.ASSERTION_AND_REASON:
      //           return Result(
      //               testId: testId!,
      //               section: question.section ?? "",
      //               questionId: question.id!,
      //               status: Status.getStatus(userSolution?.status),
      //               questionUrl: question.questionUrl ?? "",
      //               solutionUrl: question.solutionUrl ?? "",
      //               timeTaken: userSolution?.timeTaken ?? 0,
      //               negativeMark: question.negativeMark ?? 0,
      //               positiveMark: question.positiveMark ?? 0,
      //               isMultipleAnswer: question.isMultipleAnswer ?? false,
      //               userSelectedOption: userSolution?.userSelectedOption,
      //               actualAnswer: null,
      //               numericAnswer: null,
      //               userGivenAnswers: userSolution?.userGivenAnswers ??
      //                   [false, false, false, false],
      //               questionType: question.questionType ?? "",
      //               answerValidity: question.answerValidity ?? [],
      //               columnMatchAnswer:
      //                   question.columnMatchAnswer ?? ["", "", "", ""]);

      //         case QuestionType.NUMERIC:
      //           return Result(
      //               testId: testId!,
      //               section: question.section ?? "",
      //               questionId: question.id!,
      //               status: Status.getStatus(userSolution?.status),
      //               questionUrl: question.questionUrl ?? "",
      //               solutionUrl: question.solutionUrl ?? "",
      //               timeTaken: userSolution?.timeTaken ?? 0,
      //               negativeMark: question.negativeMark ?? 0,
      //               positiveMark: question.positiveMark ?? 0,
      //               isMultipleAnswer: question.isMultipleAnswer ?? false,
      //               userSelectedOption: userSolution?.userSelectedOption,
      //               actualAnswer: question.numericAnswer,
      //               numericAnswer: null,
      //               userGivenAnswers: userSolution?.userGivenAnswers ??
      //                   [false, false, false, false],
      //               questionType: question.questionType ?? "",
      //               answerValidity: question.answerValidity ?? [],
      //               columnMatchAnswer:
      //                   question.columnMatchAnswer ?? ["", "", "", ""]);
      //         case QuestionType.INTEGER:
      //           return Result(
      //               testId: testId!,
      //               section: question.section ?? "",
      //               questionId: question.id!,
      //               status: Status.getStatus(userSolution?.status),
      //               questionUrl: question.questionUrl ?? "",
      //               solutionUrl: question.solutionUrl ?? "",
      //               timeTaken: userSolution?.timeTaken ?? 0,
      //               negativeMark: question.negativeMark ?? 0,
      //               positiveMark: question.positiveMark ?? 0,
      //               isMultipleAnswer: question.isMultipleAnswer ?? false,
      //               userSelectedOption: userSolution?.userSelectedOption,
      //               actualAnswer: null,
      //               numericAnswer: null,
      //               userGivenAnswers: userSolution?.userGivenAnswers ??
      //                   [false, false, false, false],
      //               questionType: question.questionType ?? "",
      //               answerValidity: question.answerValidity ?? [],
      //               columnMatchAnswer:
      //                   question.columnMatchAnswer ?? ["", "", "", ""]);

      //         default:
      //           return Result(
      //               testId: testId!,
      //               section: question.section ?? "",
      //               questionId: question.id!,
      //               status: Status.getStatus(userSolution?.status),
      //               questionUrl: question.questionUrl ?? "",
      //               solutionUrl: question.solutionUrl ?? "",
      //               timeTaken: userSolution?.timeTaken ?? 0,
      //               negativeMark: question.negativeMark ?? 0,
      //               positiveMark: question.positiveMark ?? 0,
      //               isMultipleAnswer: question.isMultipleAnswer ?? false,
      //               userSelectedOption: userSolution?.userSelectedOption,
      //               actualAnswer: null,
      //               numericAnswer: null,
      //               userGivenAnswers: userSolution?.userGivenAnswers ??
      //                   [false, false, false, false],
      //               questionType: question.questionType ?? "NA",
      //               answerValidity: question.answerValidity ?? [],
      //               columnMatchAnswer:
      //                   question.columnMatchAnswer ?? ["", "", "", ""]);
      //       }
      //     }).toList();
      //   }
    }
    return [];
  }

  Future<List<Result>> viewSolutions({
    ///TestSoltuionsModelClass
    required int testId,
  }) async {
    final jauth = ref.read(authenticationProvider)?.jauth;

    Map<String, String> headers = {};
    headers.addAll({"Content-Type": "application/json", "Jauth": jauth!});

    return await http
        .get(
            Uri.parse(
                "$BASE_URL/mtest/getMockTestQuestionsForWeb/$testId/1080/2028/1?isMobile=true"),
            headers: headers)
        .then((response) async {
      print("test solutions ${response.body}");
      Map<String, dynamic> data = json.decode(response.body);

      // // Accessing the 'questionMobileVos' list from the decoded JSON
      // List<dynamic> jsonQuestions = data['questionMobileVos'];

      // // Mapping JSON list to List<QuestionMobileVosTwo>
      // List<QuestionMobileVosTwo> questions = jsonQuestions.map((questionJson) {
      //   return QuestionMobileVosTwo.fromJson(questionJson);
      // }).toList();

      //   // print("object ${questions.length}");

      //   return questions;

      // final SubmitTestResponse submitTestResponse  = SubmitTestResponse.fromJson(data);
      // print("data subm ${submitTestResponse.batchId}");
      // print("RESPONSE ::");
      // print(response.body);
      return convertToResult(ViewSolution.fromJson(data));
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      throw Exception(error);
    });
  }
}

class AlreadyLoggedInOnOtherDeviceException implements Exception {}

class SomethingWentWrongException implements Exception {}
