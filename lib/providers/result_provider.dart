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

  Future<http.Response> getAllResultsFromJeeniServer() async {
    final response = await ref.read(networkProvider).networkHandlerMethod(url: "$BASE_URL/mtest/getAttemptedTestByStudentId", httpMethodType: RequestType.get);

    if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        resultData = jsonList.map((json) => ResultModelClass.fromJson(json)).toList();
        notifyListeners();
      }

      return response;

  }

  Future<bool> getResultDetailsFromJeeniServer(int resultID) async {
    Map<String, String> headers = {"Content-Type": "application/json",};
    
    final responseData = await ref.read(networkProvider).networkHandlerMethod(
        url: "$BASE_URL/report/getRank/${resultID}",
        httpMethodType: RequestType.get,headers: headers);

        if(responseData.statusCode == 200){
          // print("data ${responseData.body}");
          resultDetailsData = jsonDecode(responseData.body);
          notifyListeners();
        }
        // resultDetailsData = jsonDecode(responseData.body);

    

    return true;
  }
}
