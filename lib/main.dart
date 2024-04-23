import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/auth/login_page.dart';
import 'package:jeeni/pages/dashboard.dart';
import 'package:jeeni/providers/auth_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(authenticationProvider);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'jeeni',
          home: user.authenticationState == AuthenticationState.loggedIn
              ? Dashboard()
              : const LoginPage(),
        );
      },
    );
  }
}
