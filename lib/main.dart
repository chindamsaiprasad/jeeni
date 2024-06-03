import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/auth/login_page.dart';
import 'package:jeeni/pages/dashboard.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/pages/solution/view_questions_solution.dart';
import 'package:jeeni/pages/splash_page.dart';
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
        // return MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   title: 'jeeni',
        //   home: ViewQuestionSolution(
        //     solutionProvider: ChangeNotifierProvider(
        //       (ref) => SolutionProvider(
        //         ref: ref,
        //       ),
        //     ),
        //   ),
        // );
        if (user == null) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'jeeni',
            home: LoginPage(),
          );
        }

        switch (user.authenticationState) {
          case AuthenticationState.loading:
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'jeeni',
              home: SplashPage(),
            );
          case AuthenticationState.loggedIn:
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'jeeni',
              home: Dashboard(),
            );
          case AuthenticationState.loggedOut:
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'jeeni',
              home: LoginPage(),
            );
        }

        // return MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   title: 'jeeni',
        //   // home: TestInstructions(),
        //   home: user != null &&
        //           user.authenticationState == AuthenticationState.loggedIn
        //       ? Dashboard()
        //       : const LoginPage(),
        // );
      },
    );
  }
}
