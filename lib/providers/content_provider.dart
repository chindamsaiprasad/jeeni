import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jeeni/response_models/content_response.dart';

final contentProvider =
    ChangeNotifierProvider((ref) => ContentProvider(ref: ref));

class ContentProvider with ChangeNotifier {
  late ContentResponse contentResponse;

  final Ref ref;
  ContentProvider({
    required this.ref,
  });

  Future<bool> getAllSubscribedCoursesFromJeeniServer() async {
    return ref
        .read(networkProvider)
        .getAllSubscribedCoursesFromJeeniServer()
        .then((ContentResponse contentResponse) {
      this.contentResponse = contentResponse;
      return true;
    });
    // final jauth = ref.read(authenticationProvider)?.jauth;

    // Map<String, String> headers = {};

    // headers.addAll({"Content-Type": "application/json", "Jauth": jauth!});
    // return await http
    //     .get(Uri.parse("$BASE_URL/jca/content"), headers: headers)
    //     .then((response) {
    //   var responseData = json.decode(response.body);
    //   contentResponse = ContentResponse.fromJson(responseData);
    //   return true;
    // }).catchError((error) {
    //   // TODO :: ERROR HANDELING
    //   throw Exception(error);
    // });
  }
}
