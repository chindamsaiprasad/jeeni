import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/content/content_page.dart';
import 'package:jeeni/pages/dashboard/test/test_list_page.dart';
import 'package:jeeni/providers/content_provider.dart';
import 'package:jeeni/providers/test_provider.dart';

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
              // TODO :: ERROR HANDELING
            });
          },
          leading: const Icon(Icons.book),
          title: const Text("Content"),
          subtitle: const Text("Study material for student"),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_right),
          ),
        ),
        ListTile(
          onTap: () {
            ref
                .read(testProvider)
                .fetchAllTestsFromJeeniServer()
                .then((isSuccess) => {
                      if (isSuccess)
                        {
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
            });
          },
          leading: const Icon(Icons.book),
          title: const Text("Test"),
          subtitle: const Text("Tests for student"),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_right),
          ),
        ),
      ],
    );
  }
}
