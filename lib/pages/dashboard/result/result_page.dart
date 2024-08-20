import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/dashboard/result/result_details_page.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/auth_provider.dart';
import 'package:jeeni/providers/network_error_provider.dart';
import 'package:jeeni/providers/result_provider.dart';
import 'package:jeeni/response_models/result_list_response.dart';
import 'package:jeeni/utils/constants.dart';

class ResultsPage extends ConsumerStatefulWidget {
  const ResultsPage({super.key});

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends ConsumerState<ResultsPage> {
  bool isLoading = true;

  TextEditingController searchTextController = TextEditingController();

  List<ResultModelClass> resultData = [];

  bool searchenable = false;

  refreshResults(BuildContext context) {
    // Add your onPressed code here!
    OverlayLoader.show(context: context, title: "Loading...");

    ref.read(resultProvider).getAllResultsFromJeeniServer().then((response) {
      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        ref.read(networkErrorProvider).resolveError();
      }
    }).catchError((error) {
      print('Failed to fetch results: $error');
      // ref.read(networkErrorProvider).resolveError();
    }).whenComplete(() {
      OverlayLoader.hide();
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text(
          "Attempted Test",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 18,
            ),
            onPressed: () {
              // Add your onPressed code here!
              setState(() {
                searchenable = !searchenable;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.arrowsRotate,
              size: 18,
            ),
            onPressed: () {
              refreshResults(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            searchenable
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 12, right: 12, left: 12, bottom: 0),
                    child: TextField(
                      controller: searchTextController,
                      decoration: InputDecoration(
                        hintText: 'Search Test...',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ),
                      // onChanged: filterResults,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  )
                : Container(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 4, bottom: 10, left: 6, right: 6),
                child: getResultsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getResultsList() {
    resultData = ref.watch(resultProvider).resultData;

    final String searchText = searchTextController.text;

    final filteredResultData = resultData.where((data) {
      return data.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    // print("ok widget check ${resultData.length}  , and filterr ${filteredResultData.length}");

    return filteredResultData.isEmpty
        ? Center(
            child: Text(
              'No results found',
              style: TextStyle(fontSize: 18),
            ),
          )
        : SizedBox(
            // color: Colors.green,
            child: ListView.builder(
              itemCount: filteredResultData.length,
              itemBuilder: (context, index) {
                ResultModelClass data = filteredResultData[index];
                return resultCard(data);
              },
            ),
          );
  }

  Widget resultCard(ResultModelClass data) {
    Column attemptDetails() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attempted on : ${formatDateString(data.strExamDate)}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(
            "Duration : ${data.durationInMinutes} Minutes",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      );
    }

    Row getExamDetails() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              data.name ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "${data.score} out of ${data.outOfScore}",
            style: const TextStyle(fontSize: 14),
          )
        ],
      );
    }

    Row getDownloadIcons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 35,
            child: TextButton(
              onPressed: () {
                //ToDo
                OverlayLoader.show(context: context, title: "loading");
                ref
                    .read(resultProvider)
                    .getResultDetailsFromJeeniServer(data.id)
                    .then((value) {
                  // print("data $value");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultDetailsPage(data: data)),
                  );
                }).catchError((error) {
                  print('Failed to fetch results: $error');
                  // ref.read(networkErrorProvider).resolveError();
                }).whenComplete(() {
                  OverlayLoader.hide();
                });
              },
              child: const Text(
                "View Result",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          OverlayLoader.show(context: context, title: "loading");
          ref
              .read(resultProvider)
              .getResultDetailsFromJeeniServer(data.id)
              .then((value) {
            // print("data $value");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultDetailsPage(data: data)),
            );
          }).catchError((error) {
            print('Failed to fetch results: $error');
            // ref.read(networkErrorProvider).resolveError();
          }).whenComplete(() {
            OverlayLoader.hide();
          });
        },
        child: Container(
          height: 110,
          padding: EdgeInsets.all(5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2,
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getExamDetails(),
              // const SizedBox(height: 5,),
              attemptDetails(),
              // const SizedBox(height: 5,),
              getDownloadIcons(),
            ],
          ),
        ),
      ),
    );
  }
}
