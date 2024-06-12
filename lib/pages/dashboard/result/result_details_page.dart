import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jeeni/pages/dashboard/test/test_instructions.dart";
import "package:jeeni/pages/solution/solution_provider.dart";
import "package:jeeni/pages/solution/view_questions_solution.dart";
import "package:jeeni/pages/widgets/overlay_loader.dart";
import "package:jeeni/providers/result_provider.dart";
import "package:jeeni/providers/test_provider.dart";
import "package:jeeni/response_models/result_list_response.dart";
import "package:jeeni/response_models/submit_test_response.dart";
import "package:jeeni/utils/local_data_manager.dart";

class ResultDetailsPage extends ConsumerStatefulWidget {
  final ResultModelClass data;
  const ResultDetailsPage({super.key, required this.data});

  @override
  ResultDetailsPageState createState() => ResultDetailsPageState();
}

class ResultDetailsPageState extends ConsumerState<ResultDetailsPage> {
  List<dynamic> testDetails = [];

  Map<String, dynamic>? resultDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMethod();
  }

  Future<void> initMethod() async {
    var student = await LocalDataManager().loadStudentFromLocal();
    int studentId = student.id != null ? student.id! as int : 0;

    resultDetails = await ref.read(resultProvider).resultDetailsData;

    List<dynamic> testWise = resultDetails!['testWise'];

    // Function to find student by studenId
    Map<String, dynamic>? findStudentById(
        List<dynamic> students, int studenId) {
      return students.firstWhere(
        (student) => student['studenId'] == studenId,
        orElse: () => null,
      );
    }

    List<Map<String, dynamic>?> studentsList = [
      findStudentById(testWise, studentId)
    ];

    setState(() {
      testDetails = studentsList;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: Text("Result Details", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
      onPressed: () => _handleButtonPress(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      child: const Text(
        "View Solutions",
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  _handleButtonPress(BuildContext context) {
    try {
      // Show an overlay loader (assuming OverlayLoader.show is implemented)
      OverlayLoader.show(context: context);

      // Get the width and height of the device
      final deviceWidth = MediaQuery.of(context).size.width;
      final deviceHeight = MediaQuery.of(context).size.height;

      // Get the test ID from the widget data
      int testId = widget.data.id;
      print("Test ID: $testId");

      ref
      .read(testProvider)
      .viewSolutions(testId: testId)
      .then((response) {
        print("Response: ${response}");

        

        // Navigator.push(context,MaterialPageRoute(builder: (context) {
        //       return ViewQuestionSolution(solutionProvider: ChangeNotifierProvider((ref) => 
        //       SolutionProvider( submitTestResponse: SubmitTestResponse, ref: ref,),
        //                                                         ),
        //                                                       );
        //                                                     },
        //                                                   ));



      })
      .catchError((error) {
        print("Error: $error");
      })
      .whenComplete(() {
        // Hide the overlay loader after the operation completes
        OverlayLoader.hide();
      });

    } catch (error) {
      // Handle the error properly
      print("Error: $error");
    } finally {
      // Hide the overlay loader (assuming OverlayLoader.hide is implemented)
      OverlayLoader.hide();
    }
  }

}
