import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/models/student.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/response_models/content_response.dart';
import 'package:jeeni/utils/local_data_manager.dart';

const String BASE_URL = "https://exam.jeeni.in/Jeeni/rest";

final networkProvider =
    ChangeNotifierProvider<NetworkManager>((ref) => NetworkManager(ref));

class NetworkManager with ChangeNotifier {
  final Ref ref;
  NetworkManager(this.ref);

  //********************AUTH*********************//
  Future<http.Response> loginWithIdAndPassword({
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

    final response = await networkHandlerMethod(
      url: "$BASE_URL/login/processLoginAuthentication",
      httpMethodType: RequestType.post,
      headers: headers,
      body: body,
    );

    return response;
  }

  //********************CONTENT******************//

  Future<http.Response> getAllSubscribedCoursesFromJeeniServer() async {
    final response = networkHandlerMethod(url: "$BASE_URL/jca/content", httpMethodType: RequestType.get);
    return response;
  }

  //////////////////////////////////////////////////////////////
  /// netowrk handler

  Future<http.Response> networkHandlerMethod({
    required String url,
    Object? body,
    Map<String, String>? headers,
    required RequestType httpMethodType,
  }) async {
    final jauth = ref.read(authenticationProvider)?.jauth;
    // print("jauth token $jauth");

    headers ??= <String, String>{};
    headers['jauth'] = jauth ?? '';
    // headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    headers['Accept-Encoding'] = 'gzip, deflate, br, zstd';

    late http.Response response;
    late http.MultipartRequest responseTwo;

    switch (httpMethodType) {
      case RequestType.get:
        response = await http.get(
          Uri.parse(
            url,
          ),
          headers: headers,
        );

      case RequestType.post:
        response = await http.post(
          Uri.parse(
            url,
          ),
          headers: headers,
          body: body,
        );
      case RequestType.put:
        response = await http.put(
          Uri.parse(
            url,
          ),
          headers: headers,
          body: body,
        );
      case RequestType.delete:
        response = await http.delete(
          Uri.parse(
            url,
          ),
          headers: headers,
          body: body,
        );

      case RequestType.multipart:
        responseTwo = http.MultipartRequest('PUT', Uri.parse(url))
          ..headers.addAll(headers)
          ..files.add(http.MultipartFile.fromBytes(
            'multipartFile',
            body as Uint8List,
            filename: 'filename.jpg',
          ));
        var streamedResponse = await responseTwo.send();
        response = await http.Response.fromStream(streamedResponse);
    }

    // Handle different HTTP status codes
    switch (response.statusCode) {
      case 200:
        print("200 SUCCESS");
        return response;
      case 201:
        print("201 SUCCESS");
        return response;
      case 301:
        print("301 ERROR");
        return response;
      case 302:
        print("302 ERROR");
        return response;
      case 401:
        print("401 ERROR");
        return http.Response(
          json.encode({'message': 'Invalid UserName or Password'}),
          401,
          headers: response.headers,
        );
      case 403:
        print("403 ERROR");
        return http.Response(
          json.encode({'message': 'Forbidden'}),
          403,
          headers: response.headers,
        );
      case 500:
        print("500 ERROR");
        return http.Response(
          json.encode({'message': 'Internal Server Error'}),
          500,
          headers: response.headers,
        );
      default:
        print("Unhandled status code: ${response.statusCode}");
    }

    print("*********************REQUEST*******************************");
    print("URL  : $url");
    print("Response Code : ${response.statusCode}");
    print("BODY :  ${json.decode(body.toString())}");
    print("*********************RESPONSE*******************************");
    print("URL    : $url");
    print("BODY   :  ${utf8.decode(response.bodyBytes)}");

    return response;
  }
}

/////////////////////////////////////////////////////////////////////////////////////

enum RequestType {
  get("GET"),
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  multipart("MULTIPART");

  const RequestType(this.text);
  final String text;
}
