import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'jeeni',
            home: LoginPage(),
            builder: EasyLoading.init(),
          );
        }

        switch (user.authenticationState) {
          case AuthenticationState.loading:
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'jeeni',
              home: SplashPage(),
              builder: EasyLoading.init(),
            );
          case AuthenticationState.loggedIn:
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'jeeni',
              home: Dashboard(),
              builder: EasyLoading.init(),
            );
          case AuthenticationState.loggedOut:
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'jeeni',
              home: LoginPage(),
              builder: EasyLoading.init(),
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
