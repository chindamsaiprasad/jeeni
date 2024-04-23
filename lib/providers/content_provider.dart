import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/auth_provider.dart';

final contentProvider =
    ChangeNotifierProvider((ref) => ContentProvider(ref: ref));

class ContentProvider with ChangeNotifier {
  final Ref ref;
  ContentProvider({
    required this.ref,
  });

  Future<void> GetAllSubscribedCoursesArrayFromJeeniServer() async {
    Map<String, String> params = {};
    // params.put("date", lastUpdatedTimestamp);

    final jauth = ref.read(authenticationProvider).jauth;

    Map<String, String> headers = {
      "Content-Type",
      "application/json",
      "Jauth",
      jauth
    } as Map<String, String>;
  }
}
