import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jeeni/pages/widgets/overlay_loader.dart";
import "package:jeeni/providers/result_provider.dart";
import "package:jeeni/response_models/result_list_response.dart";
import "package:jeeni/utils/local_data_manager.dart";

class ResultDetailsPage extends ConsumerStatefulWidget {
  final ResultModelClass data;
  final int resultIdInt;
  const ResultDetailsPage(
      {super.key, required this.data, required this.resultIdInt});

  @override
  ResultDetailsPageState createState() => ResultDetailsPageState();
}

class ResultDetailsPageState extends ConsumerState<ResultDetailsPage> {
  List<dynamic> testDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeResultsDetails();
    });
  }

  Future<void> initializeResultsDetails() async {
    OverlayLoader.show(context: context, title: "Loading");
    var student = await LocalDataManager().loadStudentFromLocal();
    int studentId = student.id != null ? student.id! as int : 0;
    try {
      var student = await LocalDataManager().loadStudentFromLocal();

      Map<String, dynamic> responseData = await ref
          .read(resultProvider)
          .getResultDetailsFromJeeniServer(widget.resultIdInt);

      List<dynamic> testWise = responseData['testWise'];

      // Function to find student by studenId
      Map<String, dynamic>? findStudentById(
          List<dynamic> students, int studenId) {
        return students.firstWhere(
          (student) => student['studenId'] == studenId,
          orElse: () => null,
        );
      }

      // Find student with studenId == 111104 and store in a list
      // int searchStudenId = 111104;
      List<Map<String, dynamic>?> studentsList = [
        findStudentById(testWise, studentId)
      ];

      // print("data $studentsList");
      setState(() {
        testDetails = studentsList;
      });
      // Now you can access resultData after fetching it from the server
    } catch (error) {
      // Handle errors
      print('Error fetching data: $error');
    } finally {
      // Ensure the loading indicator is hidden regardless of success or failure
      OverlayLoader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text("Result Details", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(flex: 9, child: testResultContainerDetails()),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: viewSolutionButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget testResultContainerDetails() {
    Row getResultDetails(String titlename, String value) {
      return Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    titlename,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                )),
              ],
            ),
          )
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        decoration: const BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black,
          //     blurRadius: 2,
          //   ),
          // ],
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: testDetails.length,
          itemBuilder: (BuildContext context, int index) {
            final test = testDetails[index];

            var score = test['score'];
            var outOfScore = test['outOfScore'];

            return Column(
              children: [
                getResultDetails("Test Name", widget.data.name),

                Divider(),
                getResultDetails("Test Date", widget.data.strExamDate),

                Divider(),
                getResultDetails(
                    "Duration", widget.data.durationInMinutes.toString()),

                Divider(),
                getResultDetails("Total Questions",
                    widget.data.numberOfQuestions.toString()),

                Divider(),
                getResultDetails("Attempted Questions",
                    widget.data.attemptedQuestions.toString()),

                Divider(),
                getResultDetails(
                    "Correct Answers", widget.data.correctAnswer.toString()),

                Divider(),
                getResultDetails("Incorrect Answers",
                    widget.data.inCorrectAnswer.toString()),

                Divider(),
                getResultDetails(
                    "Partial Answers", widget.data.partialAnswer.toString()),

                Divider(),
                getResultDetails("Incorrect Answers", ""),

                Divider(),
                getResultDetails("Partial Answers", ""),

                Divider(),
                getResultDetails("Marks Obtained", "$score out of $outOfScore"),
                Divider(),
                getResultDetails("Bonus Marks", widget.data.bonus.toString()),

                // Divider(),
                // getResultDetails("Total Marks", test["total_marks"].toString()),

                Divider(),
                getResultDetails("Bonus Marks", ""),

                Divider(), // Add a divider after each ListTile
              ],
            );
          },
        ),
      ),
    );
  }

  Widget viewSolutionButton() {
    return ElevatedButton(
      onPressed: () {
        // to do
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      child: Text(
        "View Solutions",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
