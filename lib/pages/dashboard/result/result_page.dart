import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/result/result_details_page.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/network_error_provider.dart';
import 'package:jeeni/providers/result_provider.dart';
import 'package:jeeni/response_models/result_list_response.dart';

class ResultsPage extends ConsumerStatefulWidget {
  const ResultsPage({super.key});

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends ConsumerState<ResultsPage> {
  bool isLoading = true;
  List<ResultModelClass> resultData = [];

  TextEditingController searchTextController = TextEditingController();
  List<ResultModelClass> filteredResults = [];

  void filterResults(String searchText) {
    setState(() {
      filteredResults = resultData
          .where((result) =>
              result.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    resultData = ref.read(resultProvider).resultData;
    filteredResults = resultData;
  }

// Future<void> initializeResults() async {
//   try {
//     resultData = await ref.read(resultProvider).getAllResultsFromJeeniServer();
//     setState(() {
//       filteredResults = resultData;
//     });
//     // Now you can access resultData after fetching it from the server
//   } catch (error) {
//     // Handle errors

//     // ref.read(networkErrorProvider.notifier).resolveError(error);
//     ref.read(authenticationProvider.notifier).updateAuthState(AuthenticationState.alreadyLogInPop);

//     print('Error fetching data: $error');
//   } finally{
//     // setState(() {
//     //   isLoading = false;
//     // });
//   }
// }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchTextController,
            decoration: InputDecoration(
              hintText: 'Enter test name...',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  filterResults(searchTextController.text);
                },
              ),
            ),
            onChanged: filterResults,
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 4, bottom: 10, left: 2, right: 2),
            child: SizedBox(
              // color: Colors.green,
              child: ListView.builder(
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  ResultModelClass data = filteredResults[index];
                  return resultCard(data);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget resultCard(ResultModelClass data) {
    RichText attemptDetails() {
      return RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Attempted on : ",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextSpan(
              text: "${data.examDate} ( Duration ${data.durationInMinutes} )",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      );
    }

    Row getExamDetails() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.name ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "${data.score} out of ${data.outOfScore}",
            style: const TextStyle(fontSize: 12),
          )
        ],
      );
    }

    IntrinsicHeight getDownloadIcons() {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                //ToDo
                OverlayLoader.show(context: context, title: "loading");
                ref
                    .read(resultProvider)
                    .getResultDetailsFromJeeniServer(data.id)
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultDetailsPage(data: data)),
                  );
                }).catchError((error) {
                  print('Failed to fetch results: $error');
                  ref.read(networkErrorProvider).resolveError(error);
                }).whenComplete(() {
                  OverlayLoader.hide();
                });

              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_red_eye),
                  SizedBox(height: 4),
                  Text(
                    "VIEW",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            VerticalDivider(),
            const SizedBox(
              width: 40,
            ),
            TextButton(
              onPressed: () {
                //Todo
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh),
                  SizedBox(height: 4),
                  Text(
                    "RE-DOWNLOAD",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          attemptDetails(),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 105,
            padding: EdgeInsets.all(5),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                getExamDetails(),
                const SizedBox(
                  height: 5,
                ),
                getDownloadIcons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
