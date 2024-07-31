import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/about_page.dart';
import 'package:jeeni/pages/dashboard/content/content_page.dart';
import 'package:jeeni/pages/dashboard/result/result_page.dart';
import 'package:jeeni/pages/dashboard/test/test_list_page.dart';
import 'package:jeeni/pages/report_page.dart';
import 'package:jeeni/pages/user_profile.dart';
import 'package:jeeni/pages/widgets/logout_overlay.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/content_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';
import 'package:jeeni/providers/network_error_provider.dart';
import 'package:jeeni/providers/result_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/providers/user_provider.dart';
import 'package:jeeni/utils/local_data_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  void updateProfileData() async {
    try {
      var value = await LocalDataManager().loadStudentFromLocal();

      setState(() {
        userName = value.name ?? '';
        userEmail = value.email ?? '';
        userImageBase = value.mobileProfileImage ?? '';

        dataImage = base64Decode(value.mobileProfileImage ?? '');
      });

      // Optional: Print the loaded data
      print("name  : ${value.name}");
      // print("email : ${value.email}");
      // print("profile password : ${value.mobileProfileImage}");
    } catch (error) {
      // Handle any errors that occur during loading
      print("Error loading data: $error");
    }
  }

  final Uri _url = Uri.parse('https://www.jeeni.in/privacy-policy');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void dispose() {
    super.dispose();
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
              userProfileBoxDisplay(ref),

              ListTile(
                leading: Icon(
                  FontAwesomeIcons.house,
                  size: 20,
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
                  FontAwesomeIcons.bookOpenReader,
                  size: 20,
                  color: selectedMenu == MenuType.content
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "Content",
                  style: TextStyle(
                    color: selectedMenu == MenuType.content
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  // ref.read(menuProvider).setSelectedMenu(MenuType.content);

                  OverlayLoader.show(context: context, title: "Loading...");
                  ref
                      .read(contentProvider)
                      .getAllSubscribedCoursesFromJeeniServer()
                      .then((response) {
                        if (response.statusCode == 200) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContentPage(),
                            ),
                          );
                        } else if (response.statusCode == 204) {
                          EasyLoading.showError("Content not found");
                        } else if (response.statusCode == 401) {
                          ref.read(networkErrorProvider).resolveError();
                        }
                      })
                      .catchError((error) {})
                      .whenComplete(() => OverlayLoader.hide());

                  widget.callback();
                },
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.table_restaurant,
              //     color: selectedMenu == MenuType.selfTest
              //         ? Colors.green
              //         : Colors.black38,
              //   ),
              //   title: Text(
              //     "Self Practice",
              //     style: TextStyle(
              //       color: selectedMenu == MenuType.selfTest
              //           ? Colors.green
              //           : Colors.black,
              //     ),
              //   ),
              //   onTap: () {
              //     ref.read(menuProvider).setSelectedMenu(MenuType.selfTest);
              //     widget.callback();
              //   },
              // ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.book,
                  size: 20,
                  color: selectedMenu == MenuType.test
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "Test",
                  style: TextStyle(
                    color: selectedMenu == MenuType.test
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  // ref.read(menuProvider).setSelectedMenu(MenuType.selfTest);

                  OverlayLoader.show(context: context, title: "Loading...");
                  ref
                      .read(testProvider)
                      .fetchAllTestsFromJeeniServer()
                      .then((response) {
                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestListPage(),
                        ),
                      );
                    } else if (response.statusCode == 401) {
                      ref.read(networkErrorProvider).resolveError();
                    }
                  }).catchError((error) {
                    // TODO: Implement error handling logic
                    print('Error: $error');
                  }).whenComplete(() {
                    OverlayLoader.hide();
                  });

                  widget.callback();
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.squarePollVertical,
                  size: 20,
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
                  if (MenuType.results == ref.read(menuProvider).selectedMenu) {
                  } else {
                    // ref.read(menuProvider).setSelectedMenu(MenuType.results);
                    OverlayLoader.show(context: context, title: "Loading...");
                    ref
                        .read(resultProvider)
                        .getAllResultsFromJeeniServer()
                        .then((response) {
                      if (response.statusCode == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResultsPage(),
                          ),
                        );
                      } else if (response.statusCode == 401) {
                        ref.read(networkErrorProvider).resolveError();
                      }
                      widget.callback();
                    }).catchError((error) {
                      print('Failed to fetch results: $error');
                      // ref.read(networkErrorProvider).resolveError();
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
                  FontAwesomeIcons.triangleExclamation,
                  size: 20,
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
                  // ref.read(menuProvider).setSelectedMenu(MenuType.issueReport);
                  OverlayLoader.show(context: context, title: "Loading...");

                  Future.delayed(
                    Duration(seconds: 1),
                    () {
                      OverlayLoader.hide();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportIssuePage(),
                        ),
                      );
                    },
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ReportIssuePage(),
                  //   ),
                  // );
                  widget.callback();
                },
              ),

              Divider(),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.user,
                  color: Colors.black38,
                  size: 20,
                ),
                title: const Text(
                  "User Profile",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  OverlayLoader.show(context: context, title: "Loading...");
                  ref.read(userProvider).saveUserDetails().then((response) {
                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserProfilePage(callback: updateProfileData),
                        ),
                      );
                    } else if (response.statusCode == 401) {
                      ref.read(networkErrorProvider).resolveError();
                    }
                    widget.callback();
                  }).catchError((error) {
                    print('Failed to fetch results: $error');
                  }).whenComplete(() {
                    OverlayLoader.hide();
                  });

                  widget.callback();
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.circleExclamation,
                  size: 20,
                  color: selectedMenu == MenuType.aboutUs
                      ? Colors.green
                      : Colors.black38,
                ),
                title: Text(
                  "About us",
                  style: TextStyle(
                    color: selectedMenu == MenuType.aboutUs
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                //  onTap: _launchUrl,
                onTap: () async {
                  // ref.read(menuProvider).setSelectedMenu(MenuType.selfTest);
                  OverlayLoader.show(context: context, title: "Loading...");
                  var controller = await WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0x00000000))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onProgress: (int progress) {
                          // Update loading bar.
                        },
                        onPageStarted: (String url) {},
                        onPageFinished: (String url) {
                          OverlayLoader.hide();
                        },
                        onHttpError: (HttpResponseError error) {},
                        onWebResourceError: (WebResourceError error) {},
                        onNavigationRequest: (NavigationRequest request) {
                          if (request.url
                              .startsWith('https://www.youtube.com/')) {
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    )
                    ..loadRequest(
                        Uri.parse('https://www.jeeni.in/privacy-policy'));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutUsPage(
                              controller: controller,
                            )),
                  );
                  widget.callback();
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.powerOff,
                  size: 20,
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

  Widget userProfileBoxDisplay(WidgetRef ref) {
    Padding userProfileColumn() {
      return Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              height: 90,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  // color: const Color(0xff7654FF),
                  color: Colors.white,
                  width: 3,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://kuc-test.s3.ap-south-1.amazonaws.com/b187548d-2735-4519-84ec-815b8edeee84content'),
                  fit: BoxFit.cover,
                ),
              ),
              // color: Colors.red,
              // child: CircleAvatar(
              //   child: ClipOval(
              //     child: Image.memory(
              //       // base64Decode(userImageBase ?? ''),
              //       dataImage,
              //       fit: BoxFit.cover,
              //       errorBuilder: (context, error, stackTrace) =>
              //           const Icon(Icons.error),
              //     ),
              //   ),
              // ),
            ),
            const SizedBox(
              height: 30,
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
                // Container(
                //   width: 25,
                //   height: 25,
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.white,
                //   ),
                //   child: Stack(
                //     children: <Widget>[
                //       const Center(
                //         child: Icon(
                //           Icons.settings,
                //           size: 20,
                //           color: Colors.black,
                //         ),
                //       ),
                //       Positioned.fill(
                //         child: Material(
                //           color: Colors.transparent,
                //           child: InkWell(
                //             borderRadius: BorderRadius.circular(30),
                //             onTap: () {
                //               OverlayLoader.show(context: context, title: "Loading...");
                //               ref.read(userProvider).saveUserDetails().then((response) {
                //                 if (response.statusCode == 200) {
                //                   Navigator.push(context, MaterialPageRoute(
                //                       builder: (context) => UserProfilePage( callback: updateProfileData),
                //                     ),
                //                   );
                //                 } else if (response.statusCode == 401) {
                //                   ref.read(networkErrorProvider).resolveError();
                //                 }
                //                 widget.callback();
                //               }).catchError((error) {
                //                 print('Failed to fetch results: $error');

                //               }).whenComplete(() {
                //                 OverlayLoader.hide();
                //               });
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
