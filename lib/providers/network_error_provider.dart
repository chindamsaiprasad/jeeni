import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final networkErrorProvider =
    ChangeNotifierProvider((ref) => NetworkErrorProvider());

class NetworkErrorProvider with ChangeNotifier {
  void resolveError(error) {}
}
