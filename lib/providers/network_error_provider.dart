
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/test_provider.dart';

final networkErrorProvider =
    ChangeNotifierProvider((ref) => NetworkErrorProvider(ref));

class NetworkErrorProvider with ChangeNotifier {

  Ref ref;
  NetworkErrorProvider(this.ref);



  void resolveError() {
        ref.read(authenticationProvider.notifier).updateAuthState(AuthenticationState.alreadyLogInPop);
  }
}
