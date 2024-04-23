import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jeeni/models/student.dart';

const String BASE_URL = "https://exam.jeeni.in/Jeeni/rest/";

class NetworkManager {
  static final NetworkManager _singleton = NetworkManager._internal();
  NetworkManager._internal();

  factory NetworkManager() {
    return _singleton;
  }

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
      'deviceId': "44476",
    };

    return await http
        .post(
      Uri.parse("${BASE_URL}login/processLoginAuthentication"),
      headers: headers,
      body: body,
    )
        .then((response) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return Student.fromMap(jsonResponse);
    }).catchError((error) {
      print("ERROR :: loginWithIdAndPassword ::  $error");
      throw Exception("$error");
    });
  }
}
