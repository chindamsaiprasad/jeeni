import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/menu_provider.dart';

class NavBar extends StatelessWidget {
  final VoidCallback callback;

  const NavBar({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedMenu = ref.watch(menuProvider).selectedMenu;
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                accountName: const Text(
                  "example",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: const Text(
                  "example@gmail.com",
                  style: TextStyle(color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      "https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png",
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: selectedMenu == MenuType.home
                      ? const Color(0xff1c5e20)
                      : Colors.black,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: selectedMenu == MenuType.home
                        ? const Color(0xff1c5e20)
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  ref.read(menuProvider).setSelectedMenu(MenuType.home);
                  callback();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: selectedMenu == MenuType.settings
                      ? const Color(0xff1c5e20)
                      : Colors.black,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: selectedMenu == MenuType.settings
                        ? const Color(0xff1c5e20)
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  ref.read(menuProvider).setSelectedMenu(MenuType.settings);
                  callback();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
