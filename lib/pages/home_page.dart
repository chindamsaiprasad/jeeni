import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            } else if (response.statusCode == 204) { 
              EasyLoading.showError("Content not found");  
            } else if (response.statusCode == 401) { 
                ref.read(networkErrorProvider).resolveError();
            }
          }).catchError((error) {}).whenComplete(() => OverlayLoader.hide());
          }, FontAwesomeIcons.bookOpenReader, "Content", "Study material for student", Icons.arrow_right),

        // navigationList(() {
        //   ref.read(menuProvider).setSelectedMenu(MenuType.practiceTest);
        // }, Icons.table_restaurant, "Self Practice", "Practice here before test.",
        //     Icons.arrow_right),

        navigationList(() {
          OverlayLoader.show(context: context, title: "Loading...");
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
        }, FontAwesomeIcons.book, "Test", "Tests for student", Icons.arrow_right),

        navigationList(() {
          OverlayLoader.show(context: context, title: "Loading...");

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
        }, FontAwesomeIcons.squarePollVertical, "Results", "See the results", Icons.arrow_right),

        navigationList(() {
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
        }, Icons.warning_amber, "Issue Reporting", "Report the issue here", Icons.arrow_right),
      ],
    );
  }

  Widget navigationList(VoidCallback ontap, IconData leadingIcon,
      String titleText, String subTitleText, IconData trallingIcon) {
    return CustomListTile(
      height: 100,
      onTap: ontap,
      leading: JeeniIcon(iconData: leadingIcon),
      title: Text(titleText),
      subTitle: Text(subTitleText),
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
      maxRadius: 40,
      backgroundColor: AppColour.darkGreen,
      child: Icon(
        iconData,
        color: Colors.white,
        size: 34,
      ),
    );
  }
}



// Custom list tile definition
class CustomListTile extends StatelessWidget {
  final Widget? leading; // Optional leading widget
  final Text? title; // Required title text
  final Text? subTitle; // Optional subtitle text
  final VoidCallback? onTap; // Optional tap event handler
  final Function? onLongPress; // Optional long press event handler
  final Function? onDoubleTap; // Optional double tap event handler
  final Widget? trailing; // Optional trailing widget
  final Color? tileColor; // Optional tile background color
  final double? height; // Required height for the custom list tile

  // Constructor for the custom list tile
  const CustomListTile({
    super.key,
    this.leading,
    this.title,
    this.subTitle,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.trailing,
    this.tileColor,
    required this.height, // Make height required for clarity
  });

  @override
  Widget build(BuildContext context) {
    return Material( // Material design container for the list tile
      color: tileColor, // Set background color if provided
      child: InkWell( // Tappable area with event handlers
        onTap: onTap, // Tap event handler
        onDoubleTap: () => onDoubleTap, // Double tap event handler
        onLongPress: () => onLongPress, // Long press event handler
        child: SizedBox( // Constrain the size of the list tile
          height: height, // Set custom height from constructor
          child: Row( // Row layout for list item content
            children: [
              Padding( // Padding for the leading widget
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: leading, // Display leading widget
              ),
              Expanded( // Expanded section for title and subtitle
                child: Column( // Column layout for title and subtitle
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Align text left
                  children: [
                    // title ?? const SizedBox(), // Display title or empty space
                    Text(
                      title?.data ?? '', 
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 10), // Spacing between title and subtitle
                    subTitle ?? const SizedBox(), // Display subtitle or empty space
                  ],
                ),
              ),
              Padding( // Padding for the trailing widget
                padding: const EdgeInsets.all(12.0),
                child: trailing, // Display trailing widget
              )
            ],
          ),
        ),
      ),
    );
  }
}