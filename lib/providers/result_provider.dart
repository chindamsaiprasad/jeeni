import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/response_models/result_details_response.dart';
import 'package:jeeni/response_models/result_list_response.dart';


final resultProvider =
    ChangeNotifierProvider((ref) => ResultProvider(ref: ref));

class ResultProvider with ChangeNotifier {
  late ResultProvider resultResponse;

  final Ref ref;
  ResultProvider({
    required this.ref,
  });


  List<ResultModelClass>? resultData;



  Future<List<ResultModelClass>> getAllResultsFromJeeniServer() async {
  final jauth = ref.read(authenticationProvider)?.jauth;
  Map<String, String> headers = {
    "Accept-Encoding": "gzip, deflate, br, zstd",
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Jauth": jauth!,
  };

  // print("data");

  try {
    final response = await http.get(Uri.parse("$BASE_URL/mtest/getAttemptedTestByStudentId"), headers: headers);

    // print('Response status: ${response.statusCode}');
    // print('Response body: adf ${response.body}  addf');

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<ResultModelClass> resultData = responseData.map((json) => ResultModelClass.fromJson(json)).toList();
      // print('Data fetched successfully: ${resultData.length} items');
      return resultData;
    } else {
      print('Failed to fetch data, status code: ${response.statusCode}');
      throw Exception('Failed to fetch data, status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching data: $error');
    throw Exception('Error fetching data: $error');
  }
}



  Future<dynamic> getResultDetailsFromJeeniServer(int resultID) async {
    final jauth = ref.read(authenticationProvider)?.jauth;

    Map<String, String> headers = {};

    headers.addAll({"Content-Type": "application/json", "Jauth": jauth!});
    return await http
        .get(Uri.parse("$BASE_URL/report/getRank/$resultID"), headers: headers)
        .then((response) {
      Map<String, dynamic> responseData = json.decode(response.body);
      // print("data $responseData");
      return responseData;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      throw Exception(error);
    });
  }


}
