import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/content/content_page.dart';
import 'package:jeeni/pages/dashboard/practice_test/practice_test.dart';
import 'package:jeeni/pages/dashboard/test/test_list_page.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/content_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';
import 'package:jeeni/providers/network_error_provider.dart';
import 'package:jeeni/providers/test_provider.dart';
import 'package:jeeni/utils/app_colour.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {
            OverlayLoader.show(context: context, title: "");
            ref
                .read(contentProvider)
                .getAllSubscribedCoursesFromJeeniServer()
                .then((isSuccess) => {
                      if (isSuccess)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContentPage(),
                            ),
                          )
                        }
                    })
                .catchError((error) {
              print("getAllSubscribedCoursesFromJeeniServer   $error");
              ref.read(networkErrorProvider).resolveError(error);
              // TODO :: ERROR HANDELING
            }).whenComplete(() => OverlayLoader.hide());
          },
          leading:
              const JeeniIcon(iconData: Icons.book), //const Icon(Icons.book),
          title: const Text("Content"),
          subtitle: const Text("Study material for student"),
          trailing: const Icon(Icons.arrow_right),
        ),
        ListTile(
            onTap: () {
              ref.read(menuProvider).setSelectedMenu(MenuType.practiceTest);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const PracticeTest(),
              //   ),
              // );
            },
            leading: const JeeniIcon(
                iconData: Icons.assessment), // const Icon(Icons.assignment),
            title: const Text("Self Practice"),
            subtitle: const Text("Practice here before test."),
            trailing: const Icon(Icons.arrow_right)),
        ListTile(
          onTap: () {
            OverlayLoader.show(context: context, title: "Tests Loading...");
            ref
                .read(testProvider)
                .fetchAllTestsFromJeeniServer()
                .then((isSuccess) => {
                      if (isSuccess)
                        {
                          print(isSuccess),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TestListPage(),
                            ),
                          )
                        }
                    })
                .catchError((error) {
              // TODO :: ERROR HANDELING
            }).whenComplete(() => OverlayLoader.hide());
          },
          leading: const JeeniIcon(iconData: Icons.quiz),
          title: const Text("Test"),
          subtitle: const Text("Tests for student"),
          trailing: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}

class JeeniIcon extends StatelessWidget {
  final IconData iconData;
  const JeeniIcon({
    super.key,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 25,
      backgroundColor: AppColour.darkGreen,
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
