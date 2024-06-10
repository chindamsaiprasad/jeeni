import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/models/student.dart';
import 'package:jeeni/pages/auth/login_page.dart';
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
          } else if (next != null &&
              next.authenticationState == AuthenticationState.alreadyLogInPop) {
            AlreadyLoggedInOverlay.show(
              context: context,
              onTapYes: () {
                
                ref.read(authenticationProvider.notifier).logOut().then((value) => AlreadyLoggedInOverlay.hide());
                ref.read(menuProvider).setSelectedMenu(MenuType.home);
              },
            );
          }
        });

        final user = ref.watch(authenticationProvider);

        return user == null
            ? const LoginPage() 
            : user.authenticationState.getPage(user.authenticationState);
      }),
      builder: EasyLoading.init(),
    );
  }
}
