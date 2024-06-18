import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/content/content_page.dart';
import 'package:jeeni/pages/dashboard/practice_test/practice_test.dart';
import 'package:jeeni/pages/dashboard/result/result_page.dart';
import 'package:jeeni/pages/dashboard/test/test_list_page.dart';
import 'package:jeeni/pages/report_page.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/content_provider.dart';
import 'package:jeeni/providers/menu_provider.dart';
import 'package:jeeni/providers/network_error_provider.dart';
import 'package:jeeni/providers/result_provider.dart';
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
        
        navigationList(() {
          OverlayLoader.show(context: context, title: "loading...");
          ref.read(contentProvider) .getAllSubscribedCoursesFromJeeniServer().then((response) { 
            if (response.statusCode == 200) { 
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const ContentPage(),
                ),
              );
            } else if (response.statusCode == 401) { 
                ref.read(networkErrorProvider).resolveError();
            }
          }).catchError((error) {}).whenComplete(() => OverlayLoader.hide());
          }, Icons.menu_book, "Content", "Study material for student", Icons.arrow_right),

        // navigationList(() {
        //   ref.read(menuProvider).setSelectedMenu(MenuType.practiceTest);
        // }, Icons.table_restaurant, "Self Practice", "Practice here before test.",
        //     Icons.arrow_right),

        navigationList(() {
          OverlayLoader.show(context: context, title: "Tests Loading...");
          ref.read(testProvider).fetchAllTestsFromJeeniServer().then((response) {
            if (response.statusCode == 200) {
                Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const TestListPage(),
                        ),
                      );
                    } else if (response.statusCode == 401) {
                      ref.read(networkErrorProvider).resolveError();
                    }
                  }).catchError((error) {
                    // TODO: Implement error handling logic
                    print('Error: $error');
                  }).whenComplete(() { OverlayLoader.hide(); });
        }, Icons.quiz, "Test", "Tests for student", Icons.arrow_right),

        navigationList(() {
          OverlayLoader.show(context: context, title: "loading...");

          ref.read(resultProvider).getAllResultsFromJeeniServer().then((response) {
            if(response.statusCode == 200){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ResultsPage(),
                        ),
                      );
                      } else if(response.statusCode == 401){
                        ref.read(networkErrorProvider).resolveError();
                      }
          }).catchError((error) {
            print('Failed to fetch results: $error');
            // ref.read(networkErrorProvider).resolveError();
          }).whenComplete(() {
            OverlayLoader.hide();
          });
        }, Icons.note, "Results", "See the results", Icons.arrow_right),

        navigationList(() {
          // ref.read(menuProvider).setSelectedMenu(MenuType.issueReport);
           Navigator.push(context,MaterialPageRoute(
                            builder: (context) => const ReportIssuePage(),
                          ),
                        );
        }, Icons.warning_amber, "Issue Reporting", "Report the issue here", Icons.arrow_right),
      ],
    );
  }

  Widget navigationList(VoidCallback ontap, IconData leadingIcon,
      String titleText, String subTitleText, IconData trallingIcon) {
    return ListTile(
      onTap: ontap,
      leading: JeeniIcon(iconData: leadingIcon),
      title: Text(titleText),
      subtitle: Text(subTitleText),
      trailing: Icon(trallingIcon),
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
