import 'package:flutter/material.dart';
import 'package:jeeni/pages/content/content_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text("Content"),
          subtitle: const Text("Study material for student"),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContentPage(),
                  ));
            },
            icon: const Icon(Icons.arrow_right),
          ),
        )
      ],
    );
  }
}
