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
          print("${response.statusCode}");
          print("HEADER ${response.headers}");
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return ContentResponse.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw AlreadyLoggedInOnOtherDeviceException();
      } else {
        throw SomethingWentWrongException();
      }
    });
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
    headers['Content-Type'] = 'application/json';
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

    return response;
    if(response.statusCode == 200){
      print("200 SUCCESS");
      return response;

    } else if(response.statusCode == 201){
      print("201 SUCCESS");
    } else if (response.statusCode == 302) {
      print("302 ERROR");
    } else if (response.statusCode == 401) {
      print("401 ERROR");
      // ref.read(authenticationProvider.notifier).updateAuthState(AuthenticationState.alreadyLogInPop);
      // ref.read(authenticationProvider.notifier).logOut();
      // throw AlreadyLoggedInOnOtherDeviceException();
    } else if (response.statusCode == 403) {
      print("403 ERROR");
    }

    print("*********************REQUEST*******************************");
    print("URL  : $url");
    print("Response Code : ${response.statusCode}");
    print("BODY :  ${json.decode(body.toString())}");
    print("*********************RESPONSE*******************************");
    print("URL    : $url");
    print("BODY   :  ${utf8.decode(response.bodyBytes)}");

  }
  

}


/////////////////////////////////////////////////////////////////////////////////////
///

enum RequestType {
  get("GET"),
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  multipart("MULTIPART");

  const RequestType(this.text);
  final String text;
}







