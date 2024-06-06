import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/user_profile.dart';
import 'package:jeeni/pages/widgets/logout_overlay.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';
import 'package:jeeni/providers/user_provider.dart';
import 'package:jeeni/utils/local_data_manager.dart';

class NavBar extends StatefulWidget {
  final VoidCallback callback;

  const NavBar({
    super.key,
    required this.callback,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String userName = '';
  String userEmail = '';
  String userImageBase = '';

  @override
  void initState() {
    super.initState();

    updateProfileData(); // Call datamethod when initializing the state
  }

  void updateProfileData() {
    // print("method call nav bar"); // Optional: Print a message indicating the function has started

    LocalDataManager().loadStudentFromLocal().then((value) {
      setState(() {
        userName = value.name ?? ''; // Update userName state variable
        userEmail = value.email ?? ''; // Update userEmail state variable
        userImageBase = value.mobileProfileImage ??
            ''; // Update userImageBase state variable
      });

      // Optional: Print the loaded data
      // print("name  : ${value.name}");
      // print("email : ${value.email}");
      // print("profile password : ${value.mobileProfileImage}");
    }).catchError((error) {
      // Handle any errors that occur during loading
      print("Error loading data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedMenu = ref.watch(menuProvider).selectedMenu;

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // UserAccountsDrawerHeader(
              //   decoration: const BoxDecoration(color: Colors.white),
              //   accountName: Padding(
              //     padding: const EdgeInsets.all(2),
              //     child: Text(
              //       userName,
              //       style: TextStyle(color: Colors.black),
              //     ),
              //   ),
              //   accountEmail: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         userEmail,
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       IconButton(
              //         icon: const Icon(Icons.edit, size: 22),
              //         color: Colors.black38,
              //         onPressed: () {
              //           // Navigate to another page
              //           // callback();
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => UserProfilePage(callback: updateProfileData)),
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              //   currentAccountPicture: CircleAvatar(
              //     child: ClipOval(
              //       child: Image.memory(
              //               base64Decode(userImageBase ?? ''),
              //               fit: BoxFit.cover,
              //               errorBuilder: (context, error, stackTrace) =>
              //                   const Icon(Icons.error),
              //             ),
              //     ),
              //   ),
              // ),

              userProfileBoxDisplay(),

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
                  widget.callback();
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
                  widget.callback();
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
                  widget.callback();
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
                  widget.callback();
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

  Widget userProfileBoxDisplay() {
    Padding userProfileColumn() {
      return Padding(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 100,
              // color: Colors.red,
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.memory(
                    base64Decode(userImageBase ?? ''),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(userName.trim(),style: TextStyle(color: Colors.white, fontSize: 16),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(userEmail.trim(),style: TextStyle(color: Colors.white, fontSize: 14),),
                Container(
  width: 30, // Adjust the width and height as needed for the desired size
  height: 30,
  child: Center(
    child: IconButton(
      icon: const Icon(Icons.edit, size: 18, color: Colors.white), // Adjust the size and color of the icon as needed
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfilePage(callback: updateProfileData),
          ),
        );
      },
    ),
  ),
),

              ],
            ),
          ],
        ),
      );
    }

    return Container(
      // height: 215,
      // color: Color(0xff1c5e20),
      decoration: BoxDecoration(
        color: Color(0xff1c5e20),
        border: Border.all(color: Colors.black26)
      ),
      child: userProfileColumn(),
    );
  }
}
