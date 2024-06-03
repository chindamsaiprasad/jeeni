import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/widgets/logout_overlay.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';

class LogoutPopUpPage extends ConsumerStatefulWidget {
  const LogoutPopUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LogoutPopUpPageState();
}

class _LogoutPopUpPageState extends ConsumerState<LogoutPopUpPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 1),
      () {
        LogoutOverlay.show(
          context: context,
          onTapYes: () {
            ref.read(authenticationProvider.notifier).logOut();
          },
          onTapNo: () {
            print("_LogoutPopUpPageState");
            ref.read(menuProvider).setSelectedMenu(MenuType.home);
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(""),
    );
  }
}
