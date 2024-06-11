import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/response_models/result_list_response.dart';

final resultProvider =
    ChangeNotifierProvider((ref) => ResultProvider(ref: ref));

class ResultProvider with ChangeNotifier {
  late ResultProvider resultResponse;

  final Ref ref;
  ResultProvider({
    required this.ref,
  });

  List<ResultModelClass> resultData=[];
  Map<String, dynamic>? resultDetailsData;

  Future<bool> getAllResultsFromJeeniServer() async {
    return await ref
        .read(networkProvider)
        .networkHandlerMethod(
            url:
                "https://exam.jeeni.in/Jeeni/rest/mtest/getAttemptedTestByStudentId",
            httpMethodType: RequestType.get)
        .then((value) {
      if (value.statusCode == 200) {
        // print("response ${value.body}");
        List<dynamic> jsonList = jsonDecode(value.body);
        resultData = jsonList.map((json) => ResultModelClass.fromJson(json)).toList();

        // print("method leng ${resultData.length}");

        notifyListeners();

        return true;
      } else if (value.statusCode == 401) { 
        throw AlreadyLoggedInOnOtherDeviceException();
      } else {
        throw SomethingWentWrongException();
      }
    });

    // return results;
  }

  Future<bool> getResultDetailsFromJeeniServer(int resultID) async {
    final responseData = await ref.read(networkProvider).networkHandlerMethod(
        url: "$BASE_URL/report/getRank/${resultID}",
        httpMethodType: RequestType.get);
        resultDetailsData = jsonDecode(responseData.body);

    notifyListeners();

    return true;
  }
}
