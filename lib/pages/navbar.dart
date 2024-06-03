import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/user_profile.dart';
import 'package:jeeni/pages/widgets/logout_overlay.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';
import 'package:jeeni/utils/local_data_manager.dart';

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

        String userName = '';
        String userEmail = '';

        LocalDataManager().loadStudentFromLocal().then((student) {
          // print(student.name);
          // print(student.lastName);
          // print(student.email);

          userName = student.name ?? '';
          userEmail = student.email ?? '';
        });
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
                accountEmail: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "example@gmail.com",
                      style: TextStyle(color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 22),
                      color: Colors.black38,
                      onPressed: () {
                        // Navigate to another page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfilePage()),
                        );
                      },
                    ),
                  ],
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      "https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: selectedMenu == MenuType.home
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: selectedMenu == MenuType.home
                        ? Colors.green
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
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: selectedMenu == MenuType.settings
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  ref.read(menuProvider).setSelectedMenu(MenuType.settings);
                  callback();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.book,
                  color: selectedMenu == MenuType.results
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "Results",
                  style: TextStyle(
                    color: selectedMenu == MenuType.results
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  ref.read(menuProvider).setSelectedMenu(MenuType.results);
                  callback();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.warning_amber,
                  color: selectedMenu == MenuType.issueReport
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "Issue Reporting",
                  style: TextStyle(
                    color: selectedMenu == MenuType.issueReport
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  ref.read(menuProvider).setSelectedMenu(MenuType.issueReport);
                  callback();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: selectedMenu == MenuType.logout
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "LogOut",
                  style: TextStyle(
                    color: selectedMenu == MenuType.logout
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  print("LOGOUT");
                  // ref.read(menuProvider).toggleLogoutPopUp(true);

                  ref.read(authenticationProvider.notifier).logOutPopUp();

                  // ref.read(menuProvider).setLogOut(MenuType.logoutPopUp);

                  // callback();

                  // LogoutOverlay.show(context: context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
