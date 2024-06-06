import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/models/student.dart';

const String BASE_URL = "https://exam.jeeni.in/Jeeni/rest";

final networkProvider =
    ChangeNotifierProvider<NetworkManager>((ref) => NetworkManager(ref));

class NetworkManager with ChangeNotifier {
  final Ref ref;
  NetworkManager(this.ref);

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
}
