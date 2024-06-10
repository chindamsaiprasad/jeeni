import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/user_profile.dart';
import 'package:jeeni/pages/widgets/logout_overlay.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';
import 'package:jeeni/providers/network_error_provider.dart';
import 'package:jeeni/providers/result_provider.dart';
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

  Uint8List dataImage = Uint8List(0);

  @override
  void initState() {
    super.initState();

    updateProfileData();
  }

  void updateProfileData() {
    // print("method call nav bar");

    LocalDataManager().loadStudentFromLocal().then((value) {
      setState(() {
        userName = value.name ?? '';
        userEmail = value.email ?? '';
        userImageBase = value.mobileProfileImage ?? '';

        dataImage = base64Decode(value.mobileProfileImage ?? '');
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
                  if(MenuType.results == ref.read(menuProvider).selectedMenu){

                  } else{
                  ref.read(menuProvider).setSelectedMenu(MenuType.results);
                  OverlayLoader.show(context: context, title: "Results");

                  ref.read(resultProvider).getAllResultsFromJeeniServer().then((value) {
                    widget.callback();
                  }).catchError((error) {
                    print('Failed to fetch results: $error');
                    ref.read(networkErrorProvider).resolveError(error);
                  }).whenComplete(() {
                    OverlayLoader.hide();
                  });
                  }
                  // ref.read(menuProvider).setSelectedMenu(MenuType.results);
                  // widget.callback();
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
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 100,
              // color: Colors.red,
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.memory(
                    // base64Decode(userImageBase ?? ''),
                    dataImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              userName,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userEmail,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: <Widget>[
                      const Center(
                        child: Icon(
                          Icons.settings,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfilePage(
                                      callback: updateProfileData),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
          color: Color(0xff1c5e20), border: Border.all(color: Colors.black26)),
      child: userProfileColumn(),
    );
  }
}
