import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/response_models/test_response.dart';

final testProvider = ChangeNotifierProvider((ref) => TestProvider(ref: ref));

class TestProvider with ChangeNotifier {
  Iterable<Test> tests = [];

  final Ref ref;
  TestProvider({
    required this.ref,
  });

  fetchAllTestsFromJeeniServer() async {
    final jauth = ref.read(authenticationProvider).jauth;

    Map<String, String> headers = {};

    headers.addAll({
      "Accept-Encoding": "gzip",
      "Content-Type": "application/json",
      "Jauth": jauth!
    });
    return await http
        .get(Uri.parse("$BASE_URL/mtest/getByStudentId"), headers: headers)
        .then((response) {
      print("RESPONSE :: ${response.body}");
      var responseData = json.decode(response.body) as List;

      tests = responseData.map((test) => Test.fromJson(test));
      print("LENGTH ${this.tests.length}");
      return true;
    }).catchError((error) {
      // TODO :: ERROR HANDELING
      print("ERROR :: FETCH TEST");
      throw Exception(error);
    });
  }
}
