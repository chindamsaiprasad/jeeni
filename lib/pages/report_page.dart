import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/pages/widgets/overlay_loader.dart';
import 'package:jeeni/providers/user_provider.dart';
import 'package:screenshot/screenshot.dart';

enum SingingCharacter {
  unableLogin,
  incorrectAnswer,
  incorrectQuestion,
  testNotSeen,
  others
}

class ReportIssuePage extends ConsumerStatefulWidget {
  const ReportIssuePage({super.key});

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends ConsumerState<ReportIssuePage> {
  SingingCharacter? _character;

  int _groupValue = -1;

  int _counter = 0;
  late Uint8List _imageFile;

  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController reportTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text(
          "Report Issues",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    OptionsContainer(),
                    TextFiledContianer(),
                  ],
                )),
            reportButton(),
          ],
        ),
      ),
    );
  }

  Widget OptionsContainer() {
    
   RadioListTile<int> _myRadioButton({required String title, required int value, required void Function(int?) onChanged}) {
    return RadioListTile<int>(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 1)),
        child: Column(
          children: <Widget>[
            _myRadioButton(
            title: "Unable to login",
            value: 0,
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  _groupValue = newValue;
                }
              });
            },
          ),
          _myRadioButton(
            title: "Incorrect Answer",
            value: 1,
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  _groupValue = newValue;
                }
              });
            },
          ),
          _myRadioButton(
            title: "Incorrect Question",
            value: 2,
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  _groupValue = newValue;
                }
              });
            },
          ),
          _myRadioButton(
            title: "Test not seen",
            value: 3,
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  _groupValue = newValue;
                }
              });
            },
          ),
          _myRadioButton(
            title: "Others",
            value: 4,
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  _groupValue = newValue;
                }
              });
            },
          ),
          ],
        ),
      ),
    );
  }

  Widget TextFiledContianer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8),
          child: TextField(
            controller: reportTextController,
            maxLength: 200,
            expands: true,
            maxLines: null,
            textAlign: TextAlign.justify,
            decoration: const InputDecoration(
              hintText: "Write issues... (Only 200 characters)",
              border: InputBorder.none,
              counterText: "",
            ),
          ),
        ),
      ),
    );
  }

  Widget reportButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () async {

            screenshotController
                .capture(delay: Duration(milliseconds: 10))
                .then((capturedImage) async {
              // showImagePopup(context, capturedImage);


              OverlayLoader.show(context: context, title: "Loading...");

              ref.read(userProvider).sendScreenshotLogs(capturedImage!).then((response) {
                if(response == "OK"){
                  print('Screenshot logs sent successfully');
                setState(() {
                _groupValue = -1;
              });
              reportTextController.clear();
              FocusManager.instance.primaryFocus?.unfocus();
                EasyLoading.showSuccess("Report sent successfully.");
                } else{
                  EasyLoading.showError("Please try again later");
                }
                
              }).catchError((error) {
                print('Failed to send screenshot logs: $error');
                EasyLoading.showError("Please try again later");
              }).whenComplete(() {
                print('Operation completed');
                OverlayLoader.hide();
              });
            }).catchError((onError) {
              print(onError);
            });
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff1c5e20)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          child: Text(
            "Report",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void showImagePopup(BuildContext context, Uint8List? imageBytes) {
    if (imageBytes == null || imageBytes.isEmpty) {
      print('Invalid image data');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.memory(imageBytes),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
