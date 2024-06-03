import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/student.dart';
import 'package:jeeni/pages/auth/login_page.dart';
import 'package:jeeni/pages/dashboard.dart';
import 'package:jeeni/pages/solution/solution_provider.dart';
import 'package:jeeni/pages/solution/view_questions_solution.dart';
import 'package:jeeni/pages/splash_page.dart';
import 'package:jeeni/pages/widgets/logout_overlay.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'jeeni',
      home: Consumer(builder: (context, ref, child) {
        ref.listen<Student?>(authenticationProvider, (previous, next) {
          if (next != null &&
              next.authenticationState == AuthenticationState.logoutPopUp) {
            LogoutOverlay.show(
              context: context,
              onTapYes: () {
                ref
                    .read(authenticationProvider.notifier)
                    .logOut()
                    .whenComplete(() {
                  ref.read(menuProvider).setSelectedMenu(MenuType.home);
                  LogoutOverlay.hide();
                });
              },
              onTapNo: () {
                LogoutOverlay.hide();
              },
            );
          }
        });

        final user = ref.watch(authenticationProvider);
        return user == null
            ? const LoginPage()
            : user.authenticationState.getPage(user.authenticationState);
      }),
    );

    // switch (user.authenticationState) {
    //   case AuthenticationState.loading:
    //     return const MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'jeeni',
    //       home: SplashPage(),
    //     );
    //   case AuthenticationState.loggedIn:
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'jeeni',
    //       home: Dashboard(),
    //     );
    //   case AuthenticationState.loggedOut:
    //     print("00000000000000000000000000000000000000000");
    //     return const MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'jeeni',
    //       home: LoginPage(),
    //     );
    // }
  }
}
