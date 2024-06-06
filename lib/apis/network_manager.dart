import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/models/student.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/response_models/content_response.dart';

const String BASE_URL = "https://exam.jeeni.in/Jeeni/rest";

final networkProvider =
    ChangeNotifierProvider<NetworkManager>((ref) => NetworkManager(ref));

class NetworkManager with ChangeNotifier {
  final Ref ref;
  NetworkManager(this.ref);

  //********************AUTH*********************//
  Future<Student> loginWithIdAndPassword({
    required String userId,
    required String password,
    required String deviceIMEI,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    Map<String, String> body = {
      'loginId': userId,
      'password': password,
      'deviceId': deviceIMEI,
    };

    return await http
        .post(
      Uri.parse("$BASE_URL/login/processLoginAuthentication"),
      headers: headers,
      body: body,
    )
        .then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return Student.fromMap(jsonResponse);
      } else {
        throw Exception(response.statusCode);
      }
    });
  }

  //********************CONTENT******************//

  Future<ContentResponse> getAllSubscribedCoursesFromJeeniServer() async {
    final jauth = ref.read(authenticationProvider)?.jauth;

    Map<String, String> headers = {};

    headers.addAll({"Content-Type": "application/json", "Jauth": jauth!});
    return await http
        .get(Uri.parse("$BASE_URL/jca/content"), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return ContentResponse.fromJson(responseData);
      } else if (response.statusCode == 302) {
        throw AlreadyLoggedInOnOtherDeviceException();
      } else {
        throw SomethingWentWrongException();
      }
    });
  }
}
