import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/home_page.dart';
import 'package:jeeni/pages/navbar.dart';
import 'package:jeeni/pages/settings_page.dart';
import 'package:jeeni/providers/menu_provider.dart';

class Dashboard extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: _key,
      drawer: NavBar(
        callback: () {},
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text(ref.watch(menuProvider).selectedMenu.name.toString()),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final selectedMenu = ref.watch(menuProvider).selectedMenu;
          print("1111111111111 ${_key.currentState?.isDrawerOpen}");
          if (_key.currentState?.isDrawerOpen ?? false) {
            print("22222222222222222 ${_key.currentState?.isDrawerOpen}");
            Future.delayed(
              const Duration(seconds: 0),
              () {
                _key.currentState!.closeDrawer();
              },
            );
          }
          switch (selectedMenu) {
            case MenuType.home:
              return const HomePage();
            case MenuType.settings:
              return const SettingsPage();
          }
        },
      ),
    );
  }
}
