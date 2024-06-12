import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/providers/user_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c5e20),
        title: const Text("Report Issues", style: TextStyle(color: Colors.white,fontSize: 22),),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OptionsContainer(),
            TextFiledContianer(),
            reportButton(),
          ],
        ),
      ),
    );
  }

  Widget OptionsContainer() {
    ListTile radioOption({
      required String text,
      required SingingCharacter value,
      required SingingCharacter? groupValue,
      required void Function(SingingCharacter?) onChanged,
    }) {
      return ListTile(
        title: Text(text),
        leading: Radio<SingingCharacter>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
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
            radioOption(
              text: "Unable to login",
              value: SingingCharacter.unableLogin,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            radioOption(
              text: "Incorrect Answer",
              value: SingingCharacter.incorrectAnswer,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            radioOption(
              text: "Incorrect Question",
              value: SingingCharacter.incorrectQuestion,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            radioOption(
              text: "Test not seen",
              value: SingingCharacter.testNotSeen,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            radioOption(
              text: "Others",
              value: SingingCharacter.others,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
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
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            expands: true,
            maxLines: null,
            decoration: InputDecoration.collapsed(
              hintText: "Write issues... (Only 200 characters)",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget reportButton(){
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async{
                    File emptyImageFile = await File('path_to_empty_image.png');

                    ref.read(userProvider).sendScreenshotLogs(emptyImageFile);
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
                    "Report",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
  }
}
