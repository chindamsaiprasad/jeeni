import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/models/test_download_response.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/providers/test_progress_provider.dart';
import 'package:jeeni/response_models/submit_test_response.dart';
import 'package:jeeni/response_models/test_response.dart';
import 'package:jeeni/response_models/test_soultion.dart';
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
    
    final response = await ref.read(networkProvider).networkHandlerMethod(url: "$BASE_URL/mtest/getByStudentId", httpMethodType: RequestType.get);

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
      // 'correctAnswers': testResultRequest.correctAnswers,
      // 'isAutoSubmit': testResultRequest.isAutoSubmit,
      // 'isLogActive': testResultRequest.isLogActive,
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
      'testId': testResultRequest.testId,
      'unAttemptedQuestions': testResultRequest.unAttemptedQuestions,
    };

    String jsonString = jsonEncode(body);
    return http.post(Uri.parse(url),
        headers: headers, body: {"testResult": jsonString}).then((response) {
      print("RESPONSE :: ${response.statusCode}");
      print("RESPONSE 11 :: ${response.body}");

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
  
  Future<TestDownloadResponse> viewSolutions({    ///TestSoltuionsModelClass
    required int testId,
  }) async {
    final jauth = ref.read(authenticationProvider)?.jauth;

    Map<String, String> headers = {};
    headers.addAll({"Content-Type": "application/json", "Jauth": jauth!});

    return await http
        .get(Uri.parse("$BASE_URL/mtest/getMockTestQuestionsForWeb/$testId/1080/2028/1?isMobile=true"),
            headers: headers)
        .then((response) async {
          // print("test solutions ${response.body}");
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

      return TestDownloadResponse.fromJson(data);

    }).catchError((error) {
      // TODO :: ERROR HANDELING
      throw Exception(error);
    });
  }





}

class AlreadyLoggedInOnOtherDeviceException implements Exception {}

class SomethingWentWrongException implements Exception {}
