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

  Future<http.Response> getAllSubscribedCoursesFromJeeniServer() async {

    final response = await ref.read(networkProvider).getAllSubscribedCoursesFromJeeniServer();

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      contentResponse = ContentResponse.fromJson(responseData);
      return response;
    } else {
      return response;
    }
    
  }

}
